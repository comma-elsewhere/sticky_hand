extends CharacterBody2D
class_name Player

@export var buff: PlayerBuff

@export_enum("Tortoise", "Hare") var player_type: String

@export var base_speed: float = 300.0
@export var base_jump: float = 400.0

@export var jump_button: InputEventAction
@export var jump_buffer: Timer
@export var coyote_time: Timer

var can_jump: = true
var jump_velocity: float
var move_speed: float
var jump_count: int = 0

func _ready() -> void:
	add_to_group("Player")

func _input(event: InputEvent):
	#Handle jump and buffer jump
	if event.is_action_pressed(jump_button.action):
		jump_operator()

func _physics_process(delta: float) -> void:
	# Add the gravity
	if !is_on_floor():
		velocity += get_gravity() * delta
		
	#Reset can_jump bool
	if !can_jump and is_on_floor():
		can_jump = true
		jump_count = 0

	# Handle jump buffer
	if is_on_floor() and !jump_buffer.is_stopped():
		actual_jump()
		
	#start Coyote time
	if !is_on_floor() and can_jump and coyote_time.is_stopped():
		coyote_time.start()
		
	#Set speeds
	speed_setter()
	
	#emits candy magnet signal
	if buff.candy_magnet:
		GSig.candy_magnet.emit(self)

	move_and_slide()

func speed_setter():
	move_speed = base_speed * buff.speed_increase
	jump_velocity = base_jump * buff.jump_increase

func jump_operator():
	if can_jump or !coyote_time.is_stopped():
		actual_jump()
	elif buff.double_jump and jump_count < 2:
		actual_jump()
	else:
		jump_buffer.start()

func actual_jump():
	velocity.y = -jump_velocity
	jump_count += 1
	if buff.double_jump and jump_count >= 2:
		can_jump = false
	elif !buff.double_jump:
		can_jump = false
	
func _on_coyote_timer_timeout():
	can_jump = false

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Candy"):
		body.candy_pickup(buff.multi_candy)

func _on_visible_on_screen_notifier_2d_screen_exited():
	await get_tree().create_timer(1.0).timeout
	GFunc.player_death(self)
