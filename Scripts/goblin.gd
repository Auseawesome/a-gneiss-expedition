#extends CharacterBody2D
#
#enum State {
	#PATROL,
	#CHASE,
	#ATTACK
#}
#
#var state = State.PATROL
#var speed = 100
#var target = null
#
#func _process(delta):
	#match state:
		#State.PATROL:
			#patrol()
			#if is_player_near():
				#state = State.CHASE
		#State.CHASE:
			#chase()
			#if is_in_attack_range():
				#state = State.ATTACK
		#State.ATTACK:
			#attack()
			#if !is_in_attack_range():
				#state = State.CHASE
#
#func patrol():
	## Patrol logic here
	#pass
#func chase():
	#if target:
		#var path = get_node("../Navigation2D").get_simple_path(position, target.position)
		#if path.size() > 1:
			#move_and_slide()
#
#func attack():
	## Attack logic here
	#pass
#
#func is_player_near():
	## Logic to check if the player is nearby
	#return false
#
#func is_in_attack_range():
	## Logic to check if the player is within attack range
	#return false
