extends CharacterBody2D

enum State { PATROL, CHASE, ATTACK }
var state = State.PATROL

const MAX_SPEED = 200

var acceleration = 8

@onready var target = $"../Player"
@onready var raycast = $RayCast2D

func _ready():
	raycast.enabled = true
	raycast.add_exception(self)

func _physics_process(delta):
	var direction = (target.global_position - global_position).normalized()
	
	# Increase velocity in move direction
	velocity += direction * acceleration
	
	# Clamp velocity to max speed
	velocity = clamp(velocity.length(), 0, MAX_SPEED) * velocity.normalized()
	
	look_at(target.global_position)
	
	# Check for collision and if it would collide, accelerate away
	var collision = move_and_collide(velocity * delta, true)
	if(collision):
		velocity += collision.get_normal() * acceleration * 100
	
	# Move goblin
	move_and_collide(velocity * delta)
