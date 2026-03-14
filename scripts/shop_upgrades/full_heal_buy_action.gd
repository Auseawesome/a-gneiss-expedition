class_name FullHealBuyAction
extends BaseBuyAction

func on_buy(shop_upgrade: ShopUpgrade) -> void:
	GlobalData.player.current_health = GlobalData.player.max_health
	shop_upgrade.exhaust_shop()
