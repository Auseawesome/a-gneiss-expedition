class_name Player

extends CharacterBody2D

var speed := 100

var max_health := 50
var current_health: int:
	set(value):
		current_health=clamp(value,0,max_health)
		#if (value<0):
			
	
	
var strength := 10

func _ready() -> void:
	GlobalData.player = self
	
	current_health = max_health

func get_input():
	# Update velocity
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
	# Look at mouse
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_pos += global_position
	mouse_pos -= Vector2(get_viewport().get_window().size) / 2
	look_at(mouse_pos)


func _physics_process(delta):
	get_input()
	move_and_slide()
