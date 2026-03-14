class_name SpeedBuyAction
extends BaseBuyAction

@export var extra_speed := 25

var times_bought := 0

func on_buy(shop_upgrade: ShopUpgrade) -> void:
	GlobalData.player.speed += extra_speed
	if (times_bought == 0):
		shop_upgrade.cost = ShopUpgrade.Costs.seventy_five
	elif (times_bought == 1):
		shop_upgrade.cost = ShopUpgrade.Costs.one_hundred
	elif (times_bought >= 2):
		shop_upgrade.exhaust_shop()
	times_bought += 1
