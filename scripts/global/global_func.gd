extends Node
#place for dynamic funcs that multiple scenes need to call
#good for not copy pasting the same bits of code everywhere (and then forgetting to update some of it)

func player_death(player):
	player.get_tree().call_deferred("reload_current_scene")
	GVar.candy_collected = 0
	
func candy_add(num: int):
	GVar.candy_collected += num
