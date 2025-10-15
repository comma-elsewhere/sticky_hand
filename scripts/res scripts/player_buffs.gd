extends Resource
class_name PlayerBuff

@export var extra_lives: int = 0
@export var speed_increase: float = 1.0
@export var jump_increase: float = 1.0
@export var double_jump: bool = false
@export var wall_jump: bool = false
@export var multi_candy: bool = false
@export var candy_magnet: bool = false
#@export var low_grav: bool = false
#@export var lava_walk: bool = false
#@export var flappy_wings: bool = false

func reset_buffs():
	extra_lives = 0
	speed_increase = 1.0
	jump_increase = 1.0
	double_jump = false
	wall_jump = false
	multi_candy = false
	candy_magnet = false

func add_extra_lives(add: int):
	extra_lives += add
	
func add_speed(increase: bool):
	if increase:
		speed_increase = 1.4
	else:
		speed_increase = 1.0
	
func add_jump(increase: bool):
	if increase:
		jump_increase = 1.2
	else:
		jump_increase = 1.0
	
func set_double_jump(on: bool):
	double_jump = on
	
func set_wall_jump(on: bool):
	wall_jump = on
	
func set_multi_candy(on: bool):
	multi_candy = on
	
func set_candy_magnet(on: bool):
	candy_magnet = on
