extends Node3D

@export var rock_4: PersistentItem

var positions: Array[Vector3] = []
var times: Array[int] = []
var record: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if record:
		positions.append(rock_4.global_position)
		times.append(Time.get_ticks_msec())

func play():
	var tween = get_tree().create_tween()
	
	var newTimes = []
	for value in times:
		newTimes.append(value - times[0])
		
	var deltaTimes = []
	var counter = 0
	
	for value in newTimes:
		if counter == 0:
			deltaTimes.append(value)
		else:
			deltaTimes.append(value - newTimes[counter-1])
			
		counter += 1
	
	rock_4.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	rock_4.freeze = true
	counter = 0

	for index in deltaTimes.size():
		var correctTim = deltaTimes[index] / 1000.0
		var nextPos = positions[counter]
		tween.chain().tween_property(rock_4, "position", positions[counter], correctTim)
		counter += 1
	
	rock_4.freeze = false
	
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_4:
		print("RECORD TOGGLE")
		if !record:
			print("POSITIONS RESET!")
			positions = []
			times = []
		
		record = !record
		
	if event is InputEventKey and event.pressed and event.keycode == KEY_5:
		play()
