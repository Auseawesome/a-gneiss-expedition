extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalData.data_label = self
	
	GlobalData.data_label.text = "Health: " + str(GlobalData.player.current_health) + "\nMoney: " + str(GlobalData.coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
