extends Label

func _ready() -> void:
	var total_time := Time.get_ticks_msec() - GlobalData.player.start_time
	var minutes := total_time / 60000
	var seconds := total_time % 60000 / 1000
	var milliseconds := total_time % 1000
	text = """
		You won!
		Final score: %s
		Time: %s:%s.%s
	""" % [GlobalData.coins, minutes, seconds, milliseconds]
