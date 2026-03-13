class_name ShopUpgrade
extends Node2D

enum Costs {
	fifty = 50,
	seventy_five = 75,
	one_hundred = 100
}

@export var cost: Costs = Costs.fifty:
	set(value):
		cost = value
		$CostSprite.texture = _cost_to_sprite[cost]

@export var buy_action: BaseBuyAction

var _cost_to_sprite: Dictionary[Costs, Texture2D] = {
	Costs.fifty: preload("res://sprites/upgrades/50_cost.png"),
	Costs.seventy_five: preload("res://sprites/upgrades/75_cost.png"),
	Costs.one_hundred: preload("res://sprites/upgrades/100_cost.png")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedItem.play("default")
	$CostSprite.texture = _cost_to_sprite[cost]
	$CostSprite/Area2D.input_event.connect(handle_input)

func handle_input(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if (event.pressed):
			buy_product()

func buy_product() -> void:
	if (GlobalData.coins < cost):
		return;
	
	GlobalData.coins -= cost
	buy_action.on_buy(self)

func exhaust_shop() -> void:
	$AnimatedItem.hide()
	$CostSprite.queue_free()
	
