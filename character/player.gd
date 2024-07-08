extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
var animation_locked : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	velocity.x = move_toward(velocity.x, Input.get_axis("ui_left", "ui_right") * speed, speed)
		
	move_and_slide()
	
func update_animation():
	if not animation_locked:
		var pn =1
		
	
