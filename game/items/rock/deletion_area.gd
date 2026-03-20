extends Area3D

@export var item: XRToolsPickable
@export var animation_player: AnimationPlayer
@export var orb: MeshInstance3D

func _ready():
	reset()

# Reset all settings
func reset():
	#item.freeze = false # Freeze causes some weird physics bugs
	
	set_collision_mask_value(32, true)
	item.enabled = true
	if animation_player:
		animation_player.play("Main")
		# Why the fuck this works, but not resetting the animation player????
		# IT IS BASICALLY DOING THE SAME THING
		orb.get_active_material(0).albedo_color = "#2b5fedc8"


func _on_area_entered(area):
	#item.freeze = true # Freeze causes some weird physics bugs
	
	# Turn off collisions with area
	set_collision_mask_value(32, false)
	
	item.enabled = false
	
	if animation_player:
		animation_player.play("Delete")
