class_name OffsetTileMap

extends Resource

var layer_node: TileMapLayer

var visual_grid: Dictionary[Vector2i, int] = {}

const EAST := Vector2i(1, 0);
const SOUTH := Vector2i(0, 1);
const SE := Vector2i(1, 1);

static func new_with_layer(layer: TileMapLayer) -> OffsetTileMap:
	var new_tile_map = new()
	new_tile_map.layer_node = layer
	
	return new_tile_map

func set_tile(pos: Vector2i) -> void:
	if (!visual_grid.has(pos)):
		visual_grid[pos] = 0
	if (!visual_grid.has(pos + EAST)):
		visual_grid[pos + EAST] = 0;
	if (!visual_grid.has(pos + SOUTH)):
		visual_grid[pos + SOUTH] = 0;
	if (!visual_grid.has(pos + SE)):
		visual_grid[pos + SE] = 0;
	
	if (visual_grid[pos] & TileMapManager.TileFill.se == 0):
		visual_grid[pos] += TileMapManager.TileFill.se
	
	if (visual_grid[pos + EAST] & TileMapManager.TileFill.sw == 0):
		visual_grid[pos + EAST] += TileMapManager.TileFill.sw
	
	if (visual_grid[pos + SOUTH] & TileMapManager.TileFill.ne == 0):
		visual_grid[pos + SOUTH] += TileMapManager.TileFill.ne
	
	if (visual_grid[pos + SE] & TileMapManager.TileFill.nw == 0):
		visual_grid[pos + SE] += TileMapManager.TileFill.nw
	
	render_tile(pos)

func clear_tile(pos: Vector2i) -> void:
	if (!visual_grid.has(pos)):
		visual_grid[pos] = 0;
	if (!visual_grid.has(pos + EAST)):
		visual_grid[pos + EAST] = 0;
	if (!visual_grid.has(pos + SOUTH)):
		visual_grid[pos + SOUTH] = 0;
	if (!visual_grid.has(pos + SE)):
		visual_grid[pos + SE] = 0;
	
	if (visual_grid[pos] & TileMapManager.TileFill.se != 0):
		visual_grid[pos] -= TileMapManager.TileFill.se
	
	if (visual_grid[pos + EAST] & TileMapManager.TileFill.sw != 0):
		visual_grid[pos + EAST] -= TileMapManager.TileFill.sw
	
	if (visual_grid[pos + SOUTH] & TileMapManager.TileFill.ne != 0):
		visual_grid[pos + SOUTH] -= TileMapManager.TileFill.ne
	
	if (visual_grid[pos + SE] & TileMapManager.TileFill.nw != 0):
		visual_grid[pos + SE] -= TileMapManager.TileFill.nw
	
	render_tile(pos)

func render_tile(pos: Vector2i) -> void:
	layer_node.set_cell(pos, 0, TileMapManager.enum_to_uv[visual_grid[pos]])
	layer_node.set_cell(pos + EAST, 0, TileMapManager.enum_to_uv[visual_grid[pos + EAST]])
	layer_node.set_cell(pos + SOUTH, 0, TileMapManager.enum_to_uv[visual_grid[pos + SOUTH]])
	layer_node.set_cell(pos + SE, 0, TileMapManager.enum_to_uv[visual_grid[pos + SE]])
