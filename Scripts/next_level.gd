extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_body_entered(body):
	GlobalData.current_scene += 1;
	GlobalData.tile_map_manager.load_level(GlobalData.all_scenes[GlobalData.current_scene])
	pass
