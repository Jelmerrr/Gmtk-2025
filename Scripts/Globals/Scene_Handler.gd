extends Node
var menu_path = "res://Scenes/Views/Menu_View.tscn"
var level_path = "res://Scenes/Views/level_view.tscn"
var finish_path = "res://Scenes/Views/Finish.tscn"

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_scene(res_path):
	call_deferred("deferred_switch_scene", res_path)

func deferred_switch_scene(res_path):
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
