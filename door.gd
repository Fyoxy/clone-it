extends StaticBody3D
@export var triggers_required: int = 3
@export var triggers: Array[Node]
var _trigger_count = 0
var _tween: Tween

func _ready():
	for trigger in triggers:
		trigger.triggered.connect(adjust_trigger)

func open():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "position:y", 3.0, 3.0)

func close():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "position:y", 0.0, 0.5)

func adjust_trigger(value: int):
	_trigger_count += value
	if _trigger_count >= triggers_required:
		open()
	else:
		close()
