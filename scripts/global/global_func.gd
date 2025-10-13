extends Node

func player_death(player):
	player.get_tree().call_deferred("reload_current_scene")
	GVar.candy_collected = 0
	
func candy_add(num: int):
	GVar.candy_collected += num
