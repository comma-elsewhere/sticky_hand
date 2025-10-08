extends CharacterBody2D

@export var animation: AnimationPlayer
var candy_amount: int = 1

func _ready() -> void:
	add_to_group("Candy")
	GSig.candy_magnet.connect(magnet_to_player)
	
func candy_pickup(multicandy: bool):
	if multicandy:
		candy_amount = randi_range(1,3)
	animation.play("pickup")

func add_score():
	GFunc.candy_add(candy_amount)

func magnet_to_player(player: Node2D):
	if self.global_position.distance_to(player.global_position) < 400 :
		self.global_position = lerp(self.global_position, player.global_position, 0.04)
