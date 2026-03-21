extends Area3D
signal triggered(value: int)

@export var audio_stream_player_3d: AudioStreamPlayer3D
@onready var plate_mesh := $MeshInstance3D
var pressed := 0

func press():
	pressed += 1
	if pressed == 1:
		audio_stream_player_3d.play()
		triggered.emit(1)
		create_tween().tween_property(plate_mesh, "scale:y", 0.2, 0.1)

func release():
	pressed -= 1
	if pressed <= 0:
		triggered.emit(-1)
		create_tween().tween_property(plate_mesh, "scale:y", 1.0, 0.1)

func _on_area_entered(_area): press()
func _on_area_exited(_area): release()
func _on_body_entered(_body): press()
func _on_body_exited(_body): release()
