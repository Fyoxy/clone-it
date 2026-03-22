extends Node3D

@export var timer: Timer
@export var tick_timer: Timer
@export var clone: PackedScene

var tracked_bodies: Dictionary = {}			# Write object and clone data into
var persistent_objects: Array[Node] = [] 	# Holds all objects that will be tracked
var clones: Array[Node] = []
var player_node: Node3D
var player_initial_position: Transform3D

var clone_num: int = 0						# Currently active clone that is being recroded to
var tickCounter: int = 0					# Tick counter for syncing objects to
var maxTicks: = 999999999999999999			# Max ticks so tweening would not go over limit

func add_data(node_name: String, pos: Vector3):
	for entry in tracked_bodies[clone_num]:
		if entry["name"] == node_name:
			entry["data"].append(pos)
			break

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Get player initial pos
	var player_body_node = get_tree().get_first_node_in_group("player_body")
	player_node = player_body_node
	
	if player_node:
		player_initial_position = player_node.global_transform
		
	persistent_objects = get_tree().get_nodes_in_group("tracked")
	
	tracked_bodies[clone_num] = [] # Init emtpy array to record into
	
	# TODO: Add rotation tracking
	# Fills in base object data into dictionary
	for body in persistent_objects:
		tracked_bodies[clone_num].append({
			"name": body.name,
			"node": body,
			"data": []  # will hold [position: Vector3]
		})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func print_tracked_bodies():
	for clone_num in tracked_bodies:
		print("=== Clone %s ===" % clone_num)
		for entry in tracked_bodies[clone_num]:
			print("  Node: %s" % entry["name"])
			print("  Reference: %s" % entry["node"])
			print("  Data entries: %s" % entry["data"].size())
			for pair in entry["data"]:
				print("    Pos: %s" % pair[0])
			print("")

# Advances clone number and creates new clone with base data
# Resets all bodies grabbed to false so they would not be ignored every tick
func play():
	reset_player_pos()
	var newClone = clone.instantiate()
	clones.append(newClone)
	add_child(newClone)
	
	for body in tracked_bodies[clone_num]:
		#print_tracked_bodies()
		if body["node"] is XRToolsPickable:
			body["node"]._object_grabbed = false
			# Fixed deletion area, not the best method but works as temp for jam
			# Needs to be here so it would not start tweening final positions
			# Kind of repeating itself since it is called in reset player pos also
			body["node"].get_node("DeletionArea").reset()
			
		
	clone_num += 1
	
	# Init new clone
	tracked_bodies[clone_num] = []
	for body in persistent_objects:
		tracked_bodies[clone_num].append({
			"name": body.name,
			"node": body,
			"data": []
		})
		

	maxTicks = 99999999999999
	tickCounter = 0

# Advances clone number and creates new clone with base data
# Resets all bodies grabbed to false so they would not be ignored every tick
func delete_last_clone():
	reset_player_pos()
	var last_clone = clones.pop_back()
	
	if last_clone:
		last_clone.queue_free()
	
		# Not sure if needed for later to perhaps reset object grabbed status?
		#for body in tracked_bodies[clone_num]:
			#if body["node"] is PersistentItem:
				#body["node"]._object_grabbed = false
				
		if tracked_bodies.erase(clone_num):
			print("Removed!")
		else:
			print("Key not found")
			
		clone_num -= 1
		
		# Init new clone
		tracked_bodies[clone_num] = []
		for body in persistent_objects:
			tracked_bodies[clone_num].append({
				"name": body.name,
				"node": body,
				"data": []
			})
			
		reset_player_pos()
		# Reset ticks to max in order to record a fresh clone? I think at least
		maxTicks = 999999999999999999
		
		# Check if there even exists a clone before current one
		
		if clone_num > 0 and clone_num - 1 < tracked_bodies.size():
			var last_clone_ticks = tracked_bodies[clone_num - 1][0]["data"].size()
			# If it exists then take the tick length from the clone
			if last_clone_ticks:
				maxTicks = last_clone_ticks
		else:
			# TODO: RESET trackedbodies to default spot!!!
			pass
			
		for object in persistent_objects:
			# Fixed deletion area, not the best method but works as temp for jam
			var deletion_area = object.get_node("DeletionArea")
			if deletion_area: 
				deletion_area.reset()
				
		tickCounter = 0
		

func reset_player_pos():
	for snap_zone in get_tree().get_nodes_in_group("snap_zone"):
		snap_zone.drop_object()
		
	for body in tracked_bodies[clone_num]:
		#print_tracked_bodies()
		if body["node"] is XRToolsPickable:
			body["node"].get_node("DeletionArea").reset()
	# Reset player position and tick limit and counter
	# Bumps player pos 1 up so spawn not in ground hopefully
	for triggerable in get_tree().get_nodes_in_group("door"):
		triggerable._trigger_count = 0
	

		
	player_node.teleport(player_initial_position)
	tick_timer.start()
	
func _on_tick_timer_timeout():
	# TODO: Maybe just stop timer, but this check also for extra safety
	if tickCounter >= maxTicks:
		## Reset tracked bodies to not frozen, kind of broken
		# I have lost all fkin hope and dont know how to unfuck the freeze
		# But freezing and zeroing stops stuff from flying the fck around
		# So this is now a game mechanic and I am not fixing it
		if tracked_bodies.size() > 1:
			for body in tracked_bodies[tracked_bodies.size()-2]:
				if body["node"] is XRToolsPickable:
					body["node"].freeze = false
					body["node"].linear_velocity = Vector3.ZERO
					body["node"].angular_velocity = Vector3.ZERO
		tick_timer.stop()
		return
			
	# TODO: Should also freeze bodies when force moving rigidbody objects
	# body["node"].freeze = true
	# and unfreeze if no longer playing or object grabbed?
	
	if tickCounter == 0:
		reset_player_pos()
	
	if tracked_bodies.size() > 1:
		for body in tracked_bodies[tracked_bodies.size()-2]:
			if body["node"] is XRToolsPickable and !body["node"]._object_grabbed:
				if tickCounter < body["data"].size():
					body["node"].freeze = true
					if tickCounter == 0:
						body["node"].global_position = body["data"][tickCounter]
					else:
						var tween = get_tree().create_tween()
						tween.tween_property(body["node"], "global_position", body["data"][tickCounter], 0.05)
		
		# Secondly loop through the clone bodies
		for key in tracked_bodies:
			for body in tracked_bodies[key]:
				# If tracking clone movement now and with key ignore the current player movement
				# since tracked_bodies also contains currently tracked movement
				if body["node"] is XRToolsPlayerBody and key != clones.size():
					if tickCounter < body["data"].size():
						var tween = get_tree().create_tween()
						tween.tween_property(clones[key], "global_position", body["data"][tickCounter], 0.05)

	# TODO: If tick counter 0 then set position rather than tweening it
	for body in tracked_bodies[tracked_bodies.size()-1]:
		add_data(body["name"], body["node"].global_position)
	tickCounter += 1
