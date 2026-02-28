extends Node

var player: Player
var coins:=0:
	set(value):
		coins = value
		
		if (is_instance_valid(GlobalData.data_label)):
			GlobalData.data_label.text = "Health: " + str(GlobalData.player.current_health) + "\nMoney: " + str(GlobalData.coins)


var tile_map_manager: TileMapManager

var current_scene := 0

var data_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
