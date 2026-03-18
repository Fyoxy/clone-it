extends PanelContainer

func _on_rewind_button_button_down() -> void:
	var replay = get_tree().root.find_child("Replay", true, false)
	if replay:
		replay.play()

func _on_delete_button_button_down() -> void:
	print("deleting da guy2")
	pass # Replace with function body.


func _on_quit_button_down() -> void:
	get_tree().reload_current_scene()
