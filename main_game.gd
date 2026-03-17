extends Node3D
@onready var player_scene = preload("res://game/zones/zone_base.tscn")
@export var zone_base: PersistentZone

var starting_pos: Vector3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_pos = zone_base.global_position
	
	get_viewport().use_xr = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
