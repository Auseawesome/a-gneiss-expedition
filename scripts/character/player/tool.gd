class_name Tool

extends CharacterBody2D

enum State {
	sword,
	pickaxe
}

var state := State.sword

var sword_level = 0:
	set(value):
		sword_level = clamp(value, 0, 2)
		$Sprite2D.texture = get_texture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collision = move_and_collide(Vector2.ZERO, true)
	if (collision):
		if (collision.get_collider() is TileMapLayer && state == State.pickaxe):
			var tilePos := Vector2i((collision.get_position() - TileMapManager.OFFSET) / 16)
			GlobalData.tile_map_manager.set_tile_mat(tilePos, TileMapManager.FloorMaterial.stone_floor)

func get_texture() -> Texture2D:
	if (state == State.sword):
		if (sword_level == 0):
			return preload("res://sprites/tool/sword.png")
		elif (sword_level == 1):
			return preload("res://sprites/tool/sword_1.png")
		elif (sword_level == 2):
			return preload("res://sprites/tool/sword_2.png")
	elif (state == State.pickaxe):
		return preload("res://sprites/tool/pickaxe.png")
	# Fallback to sword
	return preload("res://sprites/tool/sword.png")

func switch_state(new_state: State) -> void:
	state = new_state
	$Sprite2D.texture = get_texture()
