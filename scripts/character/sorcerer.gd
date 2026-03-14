extends Goblin

@export var projectile_scene: PackedScene

func _physics_process(_delta: float) -> void:
	if (GlobalData.game_over):
		return
	goblin_movement(_delta)

func _ready() -> void:
	$Timer.start()
	max_speed = 10
	acceleration = 1
	max_health = 250
	bounce_acceleration = 100
	
	current_health = max_health
	
func _on_timer_timeout() -> void:
	if (GlobalData.game_over):
		return
	shoot()

func shoot():
	if GlobalData.player == null: return

	var bullet: Area2D = projectile_scene.instantiate()
	
	# Probably should be refactored to add it in a better defined location?
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	
	bullet.direction = global_position.direction_to(GlobalData.player.global_position)
	bullet.look_at(GlobalData.player.global_position)
