extends Node

# should cover the area that must always be visible
const BASE_SIZE: Vector2 = Vector2(640.0, 360.0)


func _ready() -> void:
	pass
	#_update_size()
	#get_tree().get_root().size_changed.connect(_update_size)


func _update_size() -> void:
	var sz: Vector2 = DisplayServer.window_get_size()
	var ratio: float = min(sz.x/BASE_SIZE.x, sz.y/BASE_SIZE.y)
	ratio = max(1, floor(ratio))
	get_window().content_scale_factor = ratio
