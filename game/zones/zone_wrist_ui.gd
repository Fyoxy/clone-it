extends PanelContainer

@export var rewind_button: Button
@export var delete_button: Button

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
	get_tree().reload_current_scene()

func disable_buttons(duration: float = 3.0) -> void:
	rewind_button.disabled = true
	delete_button.disabled = true
	await get_tree().create_timer(duration).timeout
	rewind_button.disabled = false
	delete_button.disabled = false
