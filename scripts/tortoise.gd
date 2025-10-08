extends Player

func _process(_delta: float) -> void:
	#Handle movement
	velocity.x = move_speed
