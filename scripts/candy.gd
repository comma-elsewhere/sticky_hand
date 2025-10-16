extends CharacterBody2D
#access the animation player
@export var animation: AnimationPlayer
#how much candy you gain when you collect it
var candy_amount: int = 1
#setup
func _ready() -> void:
	add_to_group("Candy")
	GSig.candy_magnet.connect(magnet_to_player)
	
func candy_pickup(multicandy: bool):
	#when called by player, if multicandy boolean is true, collect 2 candy
	if multicandy:
		candy_amount = 2
	#play pickup animation which does queue_free at the end
	animation.play("pickup")

func add_score():
	#when add_score is called by player, it calls the global function to add candy_amount
	GFunc.candy_add(candy_amount)

#if candy_magnet signal is emitting, candy will lerp to player within certain distance
func magnet_to_player(player: Node2D):
	if self.global_position.distance_to(player.global_position) < 400 :
		self.global_position = lerp(self.global_position, player.global_position, 0.04)
