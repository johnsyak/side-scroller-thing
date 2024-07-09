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

	var direction = Input.get_axis("ui_left", "ui_right")
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	if(is_on_floor()):
		if(direction == 1):
			animated_sprite.flip_h = false
			animated_sprite.play("run")
		elif(direction == -1):
			animated_sprite.flip_h = true
			animated_sprite.play("run")
		elif(!direction):
			animated_sprite.play("idle")
	else:
		animated_sprite.play("jump")
		velocity.y += gravity * delta
	velocity.x = move_toward(velocity.x, direction * speed, speed)
	move_and_slide()
	
func update_animation():
	if not animation_locked:
		var pn =1
		
	
