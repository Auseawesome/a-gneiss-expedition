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

var game_over := false
var ui_layer: CanvasLayer

var game_over_scene := preload("res://scenes/menus/game_over.tscn")

func player_dead() -> void:
	game_over = true
	ui_layer.add_child(game_over_scene.instantiate())
