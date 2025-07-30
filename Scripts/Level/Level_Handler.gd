extends Node

@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var grid_player: Area2D = $GridPlayer

func _physics_process(_delta: float) -> void:
	var cell = tile_map_layer.local_to_map(grid_player.position)
	if tile_map_layer.get_cell_tile_data(cell) != null:
		if tile_map_layer.get_cell_atlas_coords(cell) != Vector2i(0, 3):
			SignalBus.Update_Player_State.emit(Utils.playerSurfaceState.Walking)
		else:
			SignalBus.Update_Player_State.emit(Utils.playerSurfaceState.Sliding)
