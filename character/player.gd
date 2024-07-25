extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -400.0

@onready var ground_detection : RayCast2D = $GroundDetection
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
var animation_locked : bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float = 0

var ATTACK = "attack"
var RUN = "run"
var IDLE = "idle"
var JUMP = "jump"

func _physics_process(delta):
	print(animated_sprite.animation)
	if animated_sprite.animation != ATTACK and animated_sprite.animation_finished:
		animation_locked = false
		
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed(ATTACK):
		animation_locked = true
		animated_sprite.play(ATTACK)

	if(is_on_floor()):
		if(direction):
			update_animation(RUN)
		elif(!direction):
			update_animation(IDLE)
	else:
		update_animation(JUMP)
		velocity.y += gravity * delta
	var starting_y_pos = velocity.y
	if Input.is_action_just_pressed(JUMP) and is_on_floor():
		calculate_jump(delta)
	if(direction == 1):
		animated_sprite.flip_h = false
	elif(direction == -1):
		animated_sprite.flip_h = true
	
	velocity.x = move_toward(velocity.x, direction * speed, speed)
	move_and_slide()
	
func update_animation(animation):
	if not animation_locked:
		animated_sprite.play(animation)

func calculate_jump(delta):
	velocity.y = jump_velocity
	
func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite.animation == ATTACK):
		animation_locked = false
