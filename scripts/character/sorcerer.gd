extends Goblin

@export var preview_texture: Texture2D
@export var projectile_scene: PackedScene
@export var phase_1_tex: Texture2D
@export var phase_2_tex: Texture2D
var max_distance_from_player := 40.0;
var teleport_distance := 30.0;

var tp_preview: Sprite2D

var phase := 0

func _physics_process(_delta: float) -> void:
	if (GlobalData.game_over):
		return
	goblin_movement(_delta)

func _ready() -> void:
	$ShootTimer.start()
	$TeleportTimer.start()
	max_speed = 15
	acceleration = 2
	max_health = 1500
	bounce_acceleration = 250
	money = 25
	# This is contact damage not projectile damage
	damage = 10
	
	current_health = max_health
	
func _on_shoot_timer_timeout() -> void:
	if (GlobalData.game_over):
		return
	shoot()
	phase_check()

func shoot():
	if GlobalData.player == null: return
	
	var bullet: Area2D = projectile_scene.instantiate()
	
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	
	bullet.direction = global_position.direction_to(GlobalData.player.global_position)
	bullet.look_at(GlobalData.player.global_position)

func phase_check() -> void:
	# Double attack speed under half health but slow teleporting
	if (phase == 0 && current_health <= max_health*2/3):
		phase = 1
		acceleration = 5
		max_speed = 30
		bounce_acceleration = 400
		$ShootTimer.wait_time = 1.5
		$TeleportTimer.wait_time = 7.5
		$Sprite2D.texture = phase_1_tex
	elif (phase == 1 && current_health < max_health/3):
		phase = 2
		acceleration = 1
		max_speed = 0
		bounce_acceleration = 200
		$TeleportTimer.wait_time = 3
		$TeleportConfirmTimer.wait_time = 0.5
		$ShootTimer.wait_time = 2
		$Sprite2D.texture = phase_2_tex

func teleport_preview():
	var player = GlobalData.player
	var player_coords = player.global_position
	var random_direction = Vector2.LEFT.rotated(randf_range(0, TAU))
	var offset = player_coords + (random_direction * teleport_distance)
	
	tp_preview = Sprite2D.new()
	tp_preview.texture = preview_texture
	get_parent().add_child(tp_preview)
	
	tp_preview.global_position = offset
	
	$TeleportConfirmTimer.start()


func _on_teleport_teleport_timer_timeout() -> void:
	if (GlobalData.game_over):
		return
	var player_position = GlobalData.player.global_position
	if (player_position.distance_to(global_position) >= max_distance_from_player):
		teleport_preview()

func _on_teleport_finished() -> void:
	global_position = tp_preview.global_position
	tp_preview.queue_free()
