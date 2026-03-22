extends StaticBody3D

@onready var scene = preload("res://game/start_scene/start_scene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func crush():
	var tween = create_tween()
	tween.tween_property(self, "global_position:y",-5,5)


func _on_area_3d_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file(scene)
