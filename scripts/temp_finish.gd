extends Area2D

var player_count: int = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GVar.total_candy += GVar.candy_collected
		GVar.candy_collected = 0
		body.buff.reset_buffs()
		get_tree().call_deferred("reload_current_scene")
