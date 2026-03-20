extends StaticBody3D

@export var top: Area3D
@export var plate: StaticBody3D
@export var door: StaticBody3D
@export var platform: StaticBody3D
@export var mesh_instance_3d: MeshInstance3D

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

func down():
	var tween = create_tween()
	tween.tween_property(mesh_instance_3d,"scale:y", 0.2, 0.1)
func up():
	var tween = create_tween()
	tween.tween_property(mesh_instance_3d,"scale:y", 1, 0.1)
func _on_area_3d_area_entered(area: Area3D) -> void:
	press_count += 1
	if  press_count == 1:
		pressed = true
		down()


func _on_area_3d_area_exited(area: Area3D) -> void:
	press_count -= 1
	if press_count <= 0:
		pressed = false
		up()


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	press_count += 1
	if  press_count == 1:
		pressed = true
		down()



func _on_area_3d_body_shape_exited(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	press_count -= 1
	if press_count <= 0:
		pressed = false
		up()
