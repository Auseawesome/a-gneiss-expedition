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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func switch_state(new_state: State) -> void:
	state = new_state
	$Sprite2D.texture = state_to_texture[state]
