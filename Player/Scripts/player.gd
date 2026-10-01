extends CharacterBody3D


const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5

var direction: int = 1

@onready var animation_player: AnimationPlayer = $pepper/AnimationPlayer

func _ready() -> void:
	animation_player.play("Breathe") # TODO use state machine
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_axis := Input.get_axis("left", "right")
	if input_axis < 0:
		direction = -1
	elif input_axis > 0:
		direction = 1
	
	velocity.x = input_axis * SPEED
	move_and_slide()
