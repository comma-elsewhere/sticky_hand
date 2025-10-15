extends CharacterBody2D
class_name Player

@export var buff: PlayerBuff

@export var base_speed: float = 350.0
@export var base_jump: float = 710.0

@export var jump_buffer: Timer
@export var coyote_time: Timer

const GRAVITY: float = 2000.0

var can_jump: = true
var jump_velocity: float
var move_speed: float
var jump_count: int = 0

func _input(event: InputEvent):
	#Handle jump and buffer jump
	if event.is_action_pressed("up"):
		jump_operator()
		
	if event.is_action_pressed("down") and is_on_floor():
		platform_drop()

func _physics_process(delta: float) -> void:
	# Add the gravity
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
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
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	if buff.wall_jump and is_on_wall_only():
		wall_jump()
	
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
	
func wall_jump():
	if Input.is_action_just_pressed("up"):
		velocity.y = -jump_velocity
	elif velocity.y > 0:
		velocity.y /= 1.2

func platform_drop():
	global_position.y += 1

func _on_coyote_timer_timeout():
	can_jump = false

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Candy"):
		body.candy_pickup(buff.multi_candy)

func _on_visible_on_screen_notifier_2d_screen_exited():
	GFunc.player_death(self)
