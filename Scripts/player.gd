extends CharacterBody2D
@export var speed = 400
var is_moving

func _ready() -> void:
	GlobalData.player = self

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
func _physics_process(delta):
	get_input()
	move_and_slide()
	if  Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"):
		is_moving=true
	else:
		is_moving=false
