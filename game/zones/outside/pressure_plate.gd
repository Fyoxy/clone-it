extends StaticBody3D

@export var top: Area3D
@export var plate: StaticBody3D
@export var door: StaticBody3D
@export var platform: StaticBody3D

var pressed := false
var tween: Tween
var press_count: int = 0
func _ready():
	pass


func _process(delta: float) -> void:
	if pressed:
		if door:
			door.open()
		if platform:
			platform.move()
	else:
		if door:
			door.close()
		if platform:
			platform.move_back()
func _animate(target_y_offset: float):
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(plate, "position:y", -target_y_offset, 0.15).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	


func _on_area_3d_area_entered(area: Area3D) -> void:
	press_count += 1
	if  press_count == 1:
		pressed = true
		_animate(0.03)


func _on_area_3d_area_exited(area: Area3D) -> void:
	press_count -= 1
	if press_count <= 0:
		pressed = false
		_animate(0.0)


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	press_count += 1
	if  press_count == 1:
		pressed = true
		_animate(0.03)


func _on_area_3d_body_shape_exited(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	press_count -= 1
	if press_count <= 0:
		pressed = false
		_animate(0.0)
