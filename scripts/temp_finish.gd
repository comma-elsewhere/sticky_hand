extends Area2D

@onready var hare = get_tree().get_first_node_in_group("Hare")
@onready var tortoise = get_tree().get_first_node_in_group("Tortoise")

var player_count: int = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and player_count >= 1:
		GVar.total_candy += GVar.candy_collected
		GVar.candy_collected = 0
		hare.buff.reset_buffs()
		tortoise.buff.reset_buffs()
		get_tree().call_deferred("reload_current_scene")
		
		
	elif body.is_in_group("Player") and player_count < 1:
		player_count += 1
