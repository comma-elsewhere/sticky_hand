extends Player

func _process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration
	var direction := Input.get_axis("hare_left", "hare_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	if buff.wall_jump and is_on_wall_only():
		wall_jump()
		
func wall_jump():
	if Input.is_action_just_pressed("hare_up"):
		velocity.y = -jump_velocity
	elif velocity.y > 0:
		velocity.y /= 1.5
