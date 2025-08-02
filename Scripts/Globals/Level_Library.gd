extends Node

@onready var level1 = preload("res://Scenes/Levels/level_1.tscn")
@onready var level2 = preload("res://Scenes/Levels/level_2.tscn")
@onready var level3 = preload("res://Scenes/Levels/level_3.tscn")
@onready var level4 = preload("res://Scenes/Levels/level_4.tscn")
@onready var level5 = preload("res://Scenes/Levels/level_5.tscn")
@onready var level6 = preload("res://Scenes/Levels/level_6.tscn")

var levelDict = {
	"Level 1": {"Scene": preload("res://Scenes/Levels/level_1.tscn"), "ID": 0},
	"Level 2": {"Scene": preload("res://Scenes/Levels/level_2.tscn"), "ID": 1},
	"Level 3": {"Scene": preload("res://Scenes/Levels/level_3.tscn"), "ID": 2},
	"Level 4": {"Scene": preload("res://Scenes/Levels/level_4.tscn"), "ID": 3},
	"Level 5": {"Scene": preload("res://Scenes/Levels/level_5.tscn"), "ID": 4},
	"Level 6": {"Scene": preload("res://Scenes/Levels/level_6.tscn"), "ID": 5},
}
