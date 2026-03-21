class_name BaseDoor
extends StaticBody3D
@export var speed: float = 3
@export var triggers_required: int = 3
@export var triggers: Array[Node]
var _trigger_count = 0
var _tween: Tween
var current_pos: Vector3

func _ready():
	current_pos = global_position
	add_to_group("door")
	for trigger in triggers:
		trigger.triggered.connect(adjust_trigger)

func open():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "position:y", current_pos.y + 3.0, 3.0)

func close():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "position:y", current_pos.y, 0.5)

func adjust_trigger(value: int):
	_trigger_count += value
	if _trigger_count < 0:
		_trigger_count = 0
		
	if _trigger_count >= triggers_required:
		open()
	else:
		close()
