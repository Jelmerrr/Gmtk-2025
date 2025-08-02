extends Node2D

@onready var level_instance: Node2D = $Level_Instance
@onready var scene_transition: Node2D = $Camera2D/CanvasLayer/SceneTransition

var current_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene_transition.get_node("ColorRect").color.a = 255
	scene_transition.FadeOut()
	InstantiateLevel(LevelLibrary.level1)

func InstantiateLevel(level):
	var levelInstance = level.instantiate()
	level_instance.add_child.call_deferred(levelInstance)
	current_level = level

func SwitchLevel(level):
	scene_transition.FadeIn()
	await get_tree().create_timer(0.5).timeout
	for child in level_instance.get_children():
		child.queue_free()
	InstantiateLevel(level)
	scene_transition.FadeOut()

func _on_reset_button_pressed() -> void:
	SwitchLevel(current_level)
