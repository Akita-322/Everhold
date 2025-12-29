extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 10
var PLAYER_DATA = "res://Data/Player/"
const NAME = "Player_Data"

signal block_place(world_pos, atlas)
signal block_remove(world_pos)


func _ready() -> void:
	DirAccess.make_dir_recursive_absolute(PLAYER_DATA)
	var file = FileAccess.open(PLAYER_DATA + NAME + ".json", FileAccess.READ)
	var text = file.get_as_text()
	file.close()	
	var data = JSON.parse_string(text)
	global_position = Vector2(float(data[0]), float(data[1]))
	print(float(data[0]))
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_create_object"):
		emit_signal("block_place", get_global_mouse_position(), Vector2i(0, 0))
	if Input.is_action_just_pressed("ui_focus_next"):
		emit_signal("block_remove", get_local_mouse_position())
	if Input.is_action_just_pressed("ui_JSON_test"):
		var path = PLAYER_DATA + NAME + ".json"
		var file = FileAccess.open(path, FileAccess.WRITE)
		var data = [global_position.x, global_position.y]
		file.store_string(JSON.stringify(data))
		file.close()
		print("save_position: complete")
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		rotation = direction * ROTATION_SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		rotation = 0

	move_and_slide()
