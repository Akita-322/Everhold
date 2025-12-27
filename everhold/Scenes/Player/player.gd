extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 10

const BLOCK_SCENE = preload("res://Scenes/Block/Block.tscn")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("ui_create_object"):
		var obj = BLOCK_SCENE.instantiate()
		get_global_mouse_position()
		obj.global_position = get_global_mouse_position()
		add_child(obj)
		print(obj)
		pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		rotation = direction * ROTATION_SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		rotation = 0

	move_and_slide()
