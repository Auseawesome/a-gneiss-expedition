extends CharacterBody2D

enum State { PATROL, CHASE, ATTACK }
var state = State.PATROL
var health = 30
var first_wave_done: bool = false;
var second_wave_done: bool = false;
var third_wave_done: bool = false;
var goblin_link = preload("res://Scenes/Goblin.tscn")
const MAX_SPEED = 200
var acceleration = 8
@onready var raycast = $RayCast2D

func _ready():
	raycast.enabled = true
	raycast.add_exception(self)

func _physics_process(delta):
	var direction = (GlobalData.player.global_position - global_position).normalized()
	
	# Increase velocity in move direction
	velocity += direction * acceleration
	
	# Clamp velocity to max speed
	velocity = clamp(velocity.length(), 0, MAX_SPEED) * velocity.normalized()
	
	look_at(GlobalData.player.global_position)
	if(health < 40 && first_wave_done != true):
		for i in range(2):
			var instance = goblin_link.instantiate()
			get_parent().add_child(instance)
			first_wave_done = true;
	# Check for collision and if it would collide, accelerate away
	var collision = move_and_collide(velocity * delta, true)
	if(collision):
		velocity += collision.get_normal() * acceleration * 100
	

	# Move goblin
	move_and_collide(velocity * delta)
