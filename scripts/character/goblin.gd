class_name Goblin

extends CharacterBody2D

enum State { PATROL, CHASE, ATTACK }
var state := State.PATROL

var max_health: int
var max_speed: int
var acceleration: int
var damage: int
var bounce_acceleration: int
var money: int

var current_health: int

func _ready() -> void:
	max_health = 30
	max_speed = 50
	acceleration = 8
	damage = 5
	bounce_acceleration = 400
	money = 5
	
	current_health = max_health

func _physics_process(delta: float) -> void:
	if (GlobalData.game_over):
		return
	goblin_movement(delta)

func goblin_movement(delta: float) -> void:
	var direction = (GlobalData.player.global_position - global_position).normalized()
	# Increase velocity in move direction
	velocity += direction * acceleration
	
	# Clamp velocity to max speed
	velocity = clamp(velocity.length(), 0, max_speed) * velocity.normalized()
	
	look_at(GlobalData.player.global_position)
	
	# Check for collision and if it would collide, accelerate away
	var collision = move_and_collide(velocity * delta, true)
	if(collision):
		velocity += collision.get_normal() * bounce_acceleration
		
		if (collision.get_collider() is Player):
			var player: Player = collision.get_collider()
			player.current_health -= damage
		
		if (collision.get_collider() is Tool):
			var tool: Tool = collision.get_collider()
			if (tool.state == Tool.State.sword):
				current_health -= GlobalData.player.strength
				if (current_health <= 0):
					GlobalData.coins += money
					_on_death_extra()
					queue_free()
	
	# Move goblin
	move_and_collide(velocity * delta)

func _on_death_extra() -> void:
	pass
