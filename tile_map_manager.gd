class_name TileMapManager

extends Node2D

enum TileFill {
	ne = 0b0001,
	nw = 0b0010,
	sw = 0b0100,
	se = 0b1000
}

enum FloorMaterial {
	grass = 0
}

static var enum_to_uv: Dictionary[int, Vector2i] = {
	0b0000: Vector2i(-1, -1),
	
	0b0001: Vector2i(0, 3),
	0b0010: Vector2i(1, 3),
	0b0100: Vector2i(2, 3),
	0b1000: Vector2i(3, 3),
	
	0b0110: Vector2i(2, 0),
	0b0011: Vector2i(3, 0),
	0b1100: Vector2i(2, 1),
	0b1001: Vector2i(3, 1),
	
	0b0111: Vector2i(0, 1),
	0b1011: Vector2i(1, 1),
	0b1110: Vector2i(0, 2),
	0b1101: Vector2i(1, 2),
	
	0b1010: Vector2i(2, 2),
	0b0101: Vector2i(3, 2),
	
	0b1111: Vector2i(1, 0)
}

var tile_grid: Dictionary[Vector2i, int] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var grass_test := OffsetTileMap.new()
	grass_test.layer_node = $GrassLayer
	
	grass_test.set_tile(Vector2i(2, 2))
	grass_test.render_tile(Vector2i(2, 2))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_tile_mat(pos: Vector2i):
	if (tile_grid.has(pos)):
		return tile_grid[pos]
	
	return -1
