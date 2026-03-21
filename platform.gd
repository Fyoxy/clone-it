extends BaseDoor
@export var move_distance: float = 3
@export var move_direction: Vector3 = Vector3(1, 0, 0)
@onready var starting_pos: Vector3 = global_position
@onready var forward_pos: Vector3 = starting_pos + move_direction * move_distance

func open():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "global_position", forward_pos, 3.0)

func close():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "global_position", starting_pos, 1.0)
