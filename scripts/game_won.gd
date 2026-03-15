extends Label

func _ready() -> void:
	text = """
		You won!
		Final score: %s
	""" % GlobalData.coins
