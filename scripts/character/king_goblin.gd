class_name KingGoblin
extends Goblin
var current_wave = 0;
var goblin_scene = preload("res://scenes/characters/goblin.tscn")
var spawn_radius:float = 5.0
func _ready() -> void:
	super._ready()
	max_health = 150
	current_health = max_health
	acceleration=6
	max_speed=30
	bounce_acceleration=600

func _physics_process(delta: float) -> void:
	goblin_movement(delta)
	if(current_health <= 125 && current_wave == 0):
		for i in range(2):
			var instance = goblin_scene.instantiate()
			get_parent().add_child(instance)
			var random_direction = randf_range(0, TAU)
			var offset = Vector2.from_angle(random_direction) * spawn_radius
			instance.position = global_position + offset
			current_wave += 1;
	if(current_health <= 100 && current_wave == 1):
		for i in range(2):
			var instance = goblin_scene.instantiate()
			get_parent().add_child(instance)
			var random_direction = randf_range(0, TAU)
			var offset = Vector2.from_angle(random_direction) * spawn_radius
			instance.position = global_position + offset
			current_wave += 1;
	if(current_health <= 50 && current_wave == 2):
		for i in range(2):
			var instance = goblin_scene.instantiate()
			get_parent().add_child(instance)
			var random_direction = randf_range(0, TAU)
			var offset = Vector2.from_angle(random_direction) * spawn_radius
			instance.position = global_position + offset
			current_wave += 1;
