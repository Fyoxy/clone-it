extends StaticBody3D

@export var switch: StaticBody3D
@export var move_distance:float = 3
@export var move_direction: Vector3 = Vector3(1,0,0)

var forward_pos: Vector3
var starting_pos: Vector3
var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_pos = global_position
	forward_pos = starting_pos + move_direction * move_distance

func move():
	if tween: tween.kill()
	var tween = create_tween()
	tween.tween_property(self,"global_position", forward_pos, 3.0)
	
func move_back():
	if tween: tween.kill()
	var tween = create_tween()
	tween.tween_property(self,"global_position", starting_pos, 3.0)
