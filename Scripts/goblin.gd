extends CharacterBody2D

enum State { PATROL, CHASE, ATTACK }
var state = State.PATROL
var speed = 150 # Increased speed so you can actually see it moving

@onready var target = $"../Player"
@onready var raycast = $RayCast2D

func _ready():
	raycast.enabled = true
	raycast.add_exception(self)

func _physics_process(_delta):
	var direction = (target.global_position - global_position).normalized()
	raycast.target_position = direction * 300 
	raycast.force_raycast_update()
	if raycast.is_colliding():
		velocity = direction * speed
		look_at(raycast.target_position)
		move_and_slide()
