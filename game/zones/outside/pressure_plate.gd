extends Node3D

@export var top: Area3D
@export var plate: StaticBody3D
@export var door: StaticBody3D

var pressed := false
var tween: Tween

func _ready():
	top.body_entered.connect(_on_body_entered)
	top.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if  !pressed:
		pressed = true
		_animate(0.03)

func _on_body_exited(body):
	if pressed:
		pressed = false
		_animate(0.0)

func _process(delta: float) -> void:
	if pressed:
		door.open()
	else:
		door.close()
func _animate(target_y_offset: float):
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(plate, "position:y", -target_y_offset, 0.15).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	


func _on_area_3d_area_entered(area: Area3D) -> void:
	if  !pressed:
		pressed = true
		_animate(0.03)


func _on_area_3d_area_exited(area: Area3D) -> void:
	if pressed:
		pressed = false
		_animate(0.0)
