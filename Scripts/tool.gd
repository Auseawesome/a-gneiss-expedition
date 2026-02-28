class_name Tool

extends CharacterBody2D

enum State {
	sword,
	pickaxe
}

var state := State.sword

var state_to_texture: Dictionary[State, Texture2D] = {
	State.sword: preload("res://object_textures/sword.png"),
	State.pickaxe: preload("res://object_textures/pickaxe.png")
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collision = move_and_collide(Vector2.ZERO, true)
	if (collision):
		if (collision.get_collider() is TileMapLayer && state == State.pickaxe):
			var tilePos := Vector2i((collision.get_position() - TileMapManager.OFFSET) / 16)
			GlobalData.tile_map_manager.set_tile_mat(tilePos, TileMapManager.FloorMaterial.dirt)

func switch_state(new_state: State) -> void:
	state = new_state
	$Sprite2D.texture = state_to_texture[state]
