extends Area3D

@export var mesh_instance_3d: MeshInstance3D
@export var item: XRToolsPickable

# Reset all settings
func reset():
	#item.freeze = false # Freeze causes some weird physics bugs
	
	set_collision_mask_value(3, true)
	item.enabled = true
	mesh_instance_3d.set_surface_override_material(0, null)

func _on_area_entered(area):
	#item.freeze = true # Freeze causes some weird physics bugs
	
	# Turn off collisions with area
	set_collision_mask_value(3, false)
	
	item.enabled = false
	
	var mat = mesh_instance_3d.get_active_material(0).duplicate()
	mesh_instance_3d.set_surface_override_material(0, mat)
	var tween = create_tween()
	tween.tween_property(mat, "albedo_color:a", 0.0, 0.5)
