extends Control

@onready var scene_transition: Node2D = $Camera2D/CanvasLayer/SceneTransition

#TODO: Options?

func _ready() -> void:
	scene_transition.get_node("ColorRect").color.a = 255
	scene_transition.FadeOut()

func _on_start_button_pressed() -> void:
	scene_transition.FadeIn()
	await get_tree().create_timer(0.5).timeout
	SceneHandler.switch_scene(SceneHandler.level_path)

func _on_level_select_button_pressed() -> void:
	#TODO: Hier nog iets mee doen?
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
