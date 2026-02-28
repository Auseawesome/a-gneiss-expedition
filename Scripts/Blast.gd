extends Area2D

@export var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	# Move the bullet in the assigned direction
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Enemies"): 
		queue_free()
