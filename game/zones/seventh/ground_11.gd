extends StaticBody3D

@export var trap: StaticBody3D
@export var label_3d: Label3D
@export var trap_crush: StaticBody3D
@export var label_3d_2: Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trapped():
	var tween = create_tween()
	tween.tween_property(self, "global_position:y", 2, 2)


func _on_area_3d_body_entered(body: Node3D) -> void:
	trapped()
	label_3d.show()
	await get_tree().create_timer(2.0).timeout
	label_3d_2.show()
	trap_crush.crush()
