class_name ShieldBuyAction
extends BaseBuyAction

@export var extra_max_health := 10

var times_bought := 0

func on_buy(shop_upgrade: ShopUpgrade) -> void:
	GlobalData.player.max_health += extra_max_health
	GlobalData.player.current_health += extra_max_health
	if (times_bought == 0):
		shop_upgrade.cost = ShopUpgrade.Costs.seventy_five
	elif (times_bought == 1):
		shop_upgrade.cost = ShopUpgrade.Costs.one_hundred
	elif (times_bought >= 2):
		shop_upgrade.exhaust_shop()
	times_bought += 1
