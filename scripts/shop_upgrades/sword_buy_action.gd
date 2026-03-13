class_name SwordBuyAction
extends BaseBuyAction

@export var extra_damage := 5

func on_buy(shop_upgrade: ShopUpgrade) -> void:
	GlobalData.player.strength += extra_damage
	GlobalData.player.tool.sword_level += 1
	if (GlobalData.player.tool.sword_level == 1):
		shop_upgrade.cost = ShopUpgrade.Costs.one_hundred
	elif (GlobalData.player.tool.sword_level >= 2):
		shop_upgrade.exhaust_shop()
