extends Goblin

# 1. Rename the preload so it doesn't conflict with the variable name 'bullet'
@onready var bullet_scene = preload("res://Scenes/blast.tscn")
@onready var timer:Timer = $Timer

func _physics_process(_delta: float) -> void:
	goblin_movement(_delta)

func _ready() -> void:
	timer.start()
	max_speed = 10
	acceleration = 1
	max_health = 250
	bounce_acceleration = 100
	
	current_health = max_health
	
# This function must be connected to your Timer's 'timeout' signal!
func _on_timer_timeout() -> void:
	shoot()

func shoot():
	if GlobalData.player == null: return

	# 2. Create the instance
	var bullet = bullet_scene.instantiate()
	
	# 3. Add it to the world (not as a child of the enemy, or it will move with the enemy)
	get_tree().current_scene.add_child(bullet)
	
	# 4. Set the starting position
	bullet.global_position = global_position
	
	# 5. Tell the bullet which way to fly
	var fire_direction = global_position.direction_to(GlobalData.player.global_position)
	bullet.direction = fire_direction
	bullet.rotation = fire_direction.angle()
