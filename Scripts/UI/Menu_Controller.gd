extends Control

func _on_start_button_pressed() -> void:
	SceneHandler.switch_scene(SceneHandler.level_path)

func _on_level_select_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
