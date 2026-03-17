extends PanelContainer
@export var replay: Node3D

signal rewind_pressed

func _on_rewind_button_button_down() -> void:
	rewind_pressed.emit()


func _on_delete_button_button_down() -> void:
	print("deleting da guy2")
	pass # Replace with function body.


func _on_quit_button_down() -> void:
	get_tree().reload_current_scene()
