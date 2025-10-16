extends Control

#access to the label that needs to change
@onready var candy_label: Label = $PanelContainer/MarginContainer/CandyLabel

#visible on first load of scene
func _ready() -> void:
	visible = true
	
func _process(_delta: float) -> void:
	#game is paused if menu is visible
	get_tree().paused = visible
	#update label
	candy_label.text = str(GVar.total_candy) + " Total Candy"

#hide label, which unpauses the game
func _on_play_button_pressed() -> void:
	visible = false
