extends Area3D

@export var my_objects: Array[Node3D]

var original_rotations: Array[Vector3] = []
var spin_tweens: Array[Tween] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for obj in my_objects:
		original_rotations.append(obj.rotation)
		spin_tweens.append(null)
	start_spinning(10)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_8:
			start_spinning(10)
		elif event.keycode == KEY_9:
			reset_rotation(1.0)

func start_spinning(duration: float = 1.0):
	for i in my_objects.size():
		if spin_tweens[i]:
			spin_tweens[i].kill()
		var speed = duration + randf_range(-0.3, 0.3)
		var dir_y = 1.0 if randi() % 2 == 0 else -1.0
		var dir_x = 1.0 if randi() % 2 == 0 else -1.0
		var dir_z = 1.0 if randi() % 2 == 0 else -1.0
		spin_tweens[i] = create_tween().set_loops().set_parallel()
		spin_tweens[i].tween_property(my_objects[i], "rotation:y", TAU * dir_y, speed)\
			.as_relative()
		spin_tweens[i].tween_property(my_objects[i], "rotation:x", TAU * dir_x, speed * randf_range(1.1, 1.5))\
			.as_relative()
		spin_tweens[i].tween_property(my_objects[i], "rotation:z", TAU * dir_z, speed * randf_range(1.4, 1.8))\
			.as_relative()

func reset_rotation(duration: float = 0.5):
	for i in my_objects.size():
		if spin_tweens[i]:
			spin_tweens[i].kill()
		spin_tweens[i] = create_tween()
		spin_tweens[i].tween_property(my_objects[i], "rotation", original_rotations[i], duration)\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_CUBIC)
