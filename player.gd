extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -275.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite= $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Move_left", "Move_right")
	
	#Flip the Sprite 
	if (direction > 0):
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Play animations
	if is_on_floor():
		if(direction == 0):
			animated_sprite.play("IDLE")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
	
	move_and_slide()
