extends Area2D
@export var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO
var damage = 10
func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Player:
		GlobalData.player.current_health -= damage
		queue_free()
	elif body is StaticBody2D or body is TileMap:
		queue_free()
