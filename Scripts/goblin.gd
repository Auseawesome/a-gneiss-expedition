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
	# 1. Safety check
	if not target: return

	# 2. Update RayCast BEFORE checking collision
	var direction = (target.global_position - global_position).normalized()
	raycast.target_position = direction * 300 # Vision range
	raycast.force_raycast_update()

	# 3. Decision Logic
	if raycast.is_colliding() and raycast.get_collider() == target:
		velocity = direction * speed
		look_at(target.global_position)
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		# Optional: print(raycast.get_collider().name if raycast.is_colliding() else "Nothing")
