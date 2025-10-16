extends Area2D

#checking if body is player, adding up candy collected then reseting counter and buffs
#reload with call deferred so it doesn't break anything in the physics processing
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GVar.total_candy += GVar.candy_collected
		GVar.candy_collected = 0
		body.buff.reset_buffs()
		get_tree().call_deferred("reload_current_scene")
