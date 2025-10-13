extends CheckButton

@export_enum("Hare", "Tortoise") var player_type: String
@export_enum("add_speed", "add_jump", "set_double_jump", "set_wall_jump", "set_multi_candy", "set_candy_magnet") var function: String

@onready var hare = get_tree().get_first_node_in_group("Hare")
@onready var tortoise = get_tree().get_first_node_in_group("Tortoise")

func _process(_delta: float) -> void:
	if GVar.total_candy < 1:
		disabled = true
	else:
		disabled = false
		
func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		GVar.total_candy -= 1
	else:
		GVar.total_candy += 1
		
	if player_type == "Hare":
		hare.buff.call(function, toggled_on)
	else:
		tortoise.buff.call(function, toggled_on)
