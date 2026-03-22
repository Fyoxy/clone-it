extends StaticBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func crush():
	var tween = create_tween()
	tween.tween_property(self, "global_position:y",-5,15)


func _on_area_3d_body_entered(body: Node3D) -> void:
	var path = "res://game/start_scene/start_scene.tscn"
	var scene_base: XRToolsSceneBase = XRTools.find_xr_ancestor(self, "*", "XRToolsSceneBase")
	if scene_base:
		scene_base.load_scene(path)
