extends Node2D

@onready var level_instance: Node2D = $Level_Instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InstantiateLevel(LevelLibrary.level1)

func InstantiateLevel(level):
	var levelInstance = level.instantiate()
	level_instance.add_child.call_deferred(levelInstance)
