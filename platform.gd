extends StaticBody3D

@export var switch: StaticBody3D

var starting_pos:Vector3
var forward_pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_pos = global_position
	forward_pos = starting_pos + Vector3(2,0,0)

func move():
	var tween = create_tween()
	tween.tween_property(self,"global_position", forward_pos, 3.0)
	
func move_back():
	var tween = create_tween()
	tween.tween_property(self,"global_position", starting_pos, 3.0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = clamp(global_position.x, starting_pos.x, forward_pos.x)
