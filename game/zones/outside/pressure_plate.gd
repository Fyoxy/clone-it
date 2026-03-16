extends Node3D

@export var top: Area3D
@export var plate: StaticBody3D

var pressed := false
var tween: Tween

func _ready():
	top.body_entered.connect(_on_body_entered)
	top.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("clone_body") and !pressed:
		pressed = true
		_animate(0.03)

func _on_body_exited(body):
	if body.is_in_group("clone_body") and pressed:
		pressed = false
		_animate(0.0)

func _animate(target_y_offset: float):
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(plate, "position:y", -target_y_offset, 0.15).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
