class_name Goblin

extends CharacterBody2D

enum State { PATROL, CHASE, ATTACK }
var state := State.PATROL

var max_health: int
var max_speed: int
var acceleration: int

var current_health: int

func _ready() -> void:
	max_health = 30
	max_speed = 200
	acceleration = 8
	
	current_health = max_health

func _physics_process(delta: float) -> void:
	goblin_movement(delta)

func goblin_movement(delta:float) -> void:
	var direction = (GlobalData.player.global_position - global_position).normalized()
	
	# Increase velocity in move direction
	velocity += direction * acceleration
	
	# Clamp velocity to max speed
	velocity = clamp(velocity.length(), 0, max_speed) * velocity.normalized()
	
	look_at(GlobalData.player.global_position)
	
	# Check for collision and if it would collide, accelerate away
	var collision = move_and_collide(velocity * delta, true)
	if(collision):
		velocity += collision.get_normal() * acceleration * 100
	
	# Move goblin
	move_and_collide(velocity * delta)
