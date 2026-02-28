class_name KingGoblin
extends Goblin
var current_wave = 0;
var goblin_scene = preload("res://Scenes/Goblin.tscn")

func _ready() -> void:
	super._ready()
	max_health = 150
	current_health = 30
func _physics_process(delta: float) -> void:
	goblin_movement(delta)
	if(current_health <= 125 && current_wave == 0):
		for i in range(2):
			var instance = goblin_scene.instantiate()
			get_parent().add_child(instance)
			current_wave += 1;
	if(current_health <= 100 && current_wave == 1):
		for i in range(2):
			var instance = goblin_scene.instantiate()
			get_parent().add_child(instance)
			current_wave += 1;
	if(current_health <= 50 && current_wave == 2):
		for i in range(2):
			var instance = goblin_scene.instantiate()
			get_parent().add_child(instance)
			current_wave += 3;
