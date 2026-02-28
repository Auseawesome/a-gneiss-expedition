extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	$Timer.timeout.connect(_respawn)

func _respawn() -> void:
	process_mode=Node.PROCESS_MODE_INHERIT
	visible=true

func _on_body_entered(body):
	if body is Player:
		var player:Player =body
		player.current_health+=5 
		visible=false
		$CollisionShape2D.disabled = true
		$Timer.start()
