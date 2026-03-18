extends PanelContainer

@onready var rewind_button: Button = $MarginContainer/HBoxContainer/rewind_button
@onready var delete_button: Button = $MarginContainer/HBoxContainer/delete_button

func _on_rewind_button_button_down() -> void:
	var replay = get_tree().root.find_child("Replay", true, false)
	if replay:
		replay.play()
	disable_buttons()

func _on_delete_button_button_down() -> void:
	var replay = get_tree().root.find_child("Replay", true, false)
	if replay:
		replay.delete_last_clone()
	disable_buttons()


func _on_quit_button_down() -> void:
	# Find our scene base
	var scene_base : XRToolsSceneBase = XRTools.find_xr_ancestor(self, "*", "XRToolsSceneBase")
	if not scene_base:
		return

	scene_base.reset_scene()
		
	disable_buttons()

func disable_buttons(duration: float = 3.0) -> void:
	if (rewind_button and delete_button):
		rewind_button.disabled = true
		delete_button.disabled = true
		await get_tree().create_timer(duration).timeout
		rewind_button.disabled = false
		delete_button.disabled = false
