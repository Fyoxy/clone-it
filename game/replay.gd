extends Node3D

@export var timer: Timer

var tracked_bodies: Dictionary = {}
var clone_num: int = 0
var tickCounter: int = 0
var maxTicks: = 999999999999999999

var record: bool = false

func add_data(node_name: String, pos: Vector3):
	for entry in tracked_bodies[clone_num]:
		if entry["name"] == node_name:
			entry["data"].append(pos)
			break

# Called when the node enters the scene tree for the first time.
func _ready():
	var persistent_objects = get_tree().get_nodes_in_group("tracked")
	tracked_bodies[clone_num] = []
	for body in persistent_objects:
		tracked_bodies[clone_num].append({
			"name": body.name,
			"node": body,
			"data": []  # will hold [Vector3] pairs
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

func play():
	clone_num += 1
	#print_tracked_bodies()
	
	#rock_4.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	#rock_4.freeze = true
	#counter = 0

	#for index in deltaTimes.size():
		#var correctTim = deltaTimes[index] / 1000.0
		#var nextPos = positions[counter]
		#tween.chain().tween_property(rock_4, "position", positions[counter], correctTim)
		#counter += 1

	#rock_4.freeze = false
	
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_4:
		pass
		#print("RECORD TOGGLE")
		#if !record:5
			#print("POSITIONS RESET!")
			#positions = []
			#times = []
		#
		#record = !record
		
	if event is InputEventKey and event.pressed and event.keycode == KEY_5:
		play()
		maxTicks = tickCounter
		tickCounter = 0
		
	if event is InputEventKey and event.pressed and event.keycode == KEY_6:
		timer.start()
		tickCounter = 0


func _on_tick_timer_timeout():
	if tickCounter >= maxTicks:
		return
		
	var tween = get_tree().create_tween()
	
	for body in tracked_bodies[0]:
		if !clone_num:
			add_data(body["name"], body["node"].global_position)
		else:
			body["node"].freeze = true
			tween.tween_property(body["node"], "global_position", body["data"][tickCounter], 0.05)
	
	tickCounter += 1
