extends Area2D


# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		do_action()

func do_action():
	GlobalData.coins-=100
	GlobalData.health+=20
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
