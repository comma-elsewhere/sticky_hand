extends Control

@onready var candy_label: Label = $PanelContainer/MarginContainer/CandyLabel

func _ready() -> void:
	visible = true
	
func _process(_delta: float) -> void:
	get_tree().paused = visible
	candy_label.text = str(GVar.total_candy) + " Total Candy"

func _on_play_button_pressed() -> void:
	visible = false
