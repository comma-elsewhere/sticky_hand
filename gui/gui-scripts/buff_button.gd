extends CheckButton

#decides the function that toggling the button will call from the player
@export_enum("add_speed", "add_jump", "set_double_jump", "set_wall_jump", "set_multi_candy", "set_candy_magnet") var function: String
#gets access to player node
@onready var player = get_tree().get_first_node_in_group("Player")
#cant use button if you have no candy
func _process(_delta: float) -> void:
	if GVar.total_candy < 1:
		disabled = true
	else:
		disabled = false

func _on_toggled(toggled_on: bool) -> void:
	#add and sub candy when toggled on/off
	if toggled_on:
		GVar.total_candy -= 1
	else:
		GVar.total_candy += 1
	#call player buff resource function, passing through boolean value
	player.buff.call(function, toggled_on)
