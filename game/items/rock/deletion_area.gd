extends Area3D
@export var item: XRToolsPickable
@export var orb: MeshInstance3D
@export var omni_light_3d: OmniLight3D
var orb_material: StandardMaterial3D
var _tween: Tween
var starting_position: Vector3

func _ready():
	starting_position = get_parent().global_position
	if orb:
		orb_material = orb.get_active_material(0).duplicate()
		orb.set_surface_override_material(0, orb_material)
	reset()

func reset():
	if _tween:
		_tween.kill()
		
	get_parent().global_position = starting_position
	set_collision_mask_value(32, true)
	item.enabled = true
	if orb and orb_material:
		omni_light_3d.light_energy = 3.0
		orb_material.albedo_color = Color("#2b5fedc8")

func _on_area_entered(area):
	set_collision_mask_value(32, false)
	item.enabled = false
	if omni_light_3d:
		omni_light_3d.light_energy = 0.0
		if _tween:
			_tween.kill()
		_tween = create_tween()
		_tween.tween_property(orb_material, "albedo_color:a", 0.0, 0.5)
