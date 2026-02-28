class_name TileMapManager

extends Node2D

enum TileFill {
	ne = 0b0001,
	nw = 0b0010,
	sw = 0b0100,
	se = 0b1000
}

enum FloorMaterial {
	empty = -1,
	dirt = 0,
	grass = 1,
	stone = 2,
	world_border = 3,
	grassy_stone = 4
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

@onready var dirt_map := OffsetTileMap.new_with_layer($DirtLayer)
@onready var grass_map := OffsetTileMap.new_with_layer($GrassLayer)
@onready var stone_map := OffsetTileMap.new_with_layer($StoneLayer)

@onready var mat_to_tile_maps: Dictionary[FloorMaterial, Array] = {
	FloorMaterial.dirt: [dirt_map],
	FloorMaterial.grass: [dirt_map, grass_map],
	FloorMaterial.stone: [dirt_map, stone_map],
	FloorMaterial.world_border: [stone_map],
	FloorMaterial.grassy_stone: [dirt_map, grass_map, stone_map]
}

var tile_grid: Dictionary[Vector2i, FloorMaterial] = {}

var decorationMap: TileMapLayer

func _ready() -> void:
	load_level(load("res://Scenes/Levels/goblin_level.tscn"))

func load_level(scene: PackedScene) -> void:
	var rootNode: Node = scene.instantiate()
	var floorTiles: TileMapLayer = rootNode.find_child("Floor")
	
	if (!is_instance_valid(GlobalData.player)):
		GlobalData.player = preload("res://Scenes/Player.tscn").instantiate()
		add_child(GlobalData.player)
	
	GlobalData.player.position = (rootNode.find_child("Spawn") as Node2D).position
	
	if (decorationMap != null):
		decorationMap.queue_free()
	
	decorationMap = rootNode.find_child("Decorations")
	decorationMap.position = Vector2(8, 8)
	decorationMap.owner = null
	decorationMap.reparent(self)
	
	for tile: Vector2i in floorTiles.get_used_cells():
		set_tile_mat(tile, floorTiles.get_cell_source_id(tile) as FloorMaterial)
	
	rootNode.queue_free()
	GlobalData.player.move_to_front()

func get_tile_mat(pos: Vector2i):
	if (tile_grid.has(pos)):
		return tile_grid[pos]
	
	return -1

func set_tile_mat(pos: Vector2i, mat: FloorMaterial) -> void:
	# Clear previous tile at that position
	if (tile_grid.has(pos)):
		for map: OffsetTileMap in mat_to_tile_maps[tile_grid[pos]]:
			map.clear_tile(pos)
	
	# Erase tile if setting mat to -1
	if (mat == FloorMaterial.empty):
		tile_grid.erase(pos)
		return;
	
	# Set new tile
	tile_grid[pos] = mat
	for map: OffsetTileMap in mat_to_tile_maps[mat]:
		map.set_tile(pos)
