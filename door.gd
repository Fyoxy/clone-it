extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func open():
	var tween = create_tween()
	tween.tween_property(self, "position:y", 3.0, 3.0)
	
func close():
	var tween = create_tween()
	tween.tween_property(self, "position:y", 0.0, 0.5)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
