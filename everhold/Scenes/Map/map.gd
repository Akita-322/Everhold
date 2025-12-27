extends Node2D

const BLOCK_SCENE = preload("res://Scenes/Block/Block.tscn")
@onready var TILEMAP: TileMapLayer = $TileMapLayer
var ground_level = 0
var Brick_Block: Vector2i = Vector2i(0, 0)
var ChangeBLock: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_create_object"):
		var mouse_position = get_global_mouse_position()
		
		var tile_spawn = TILEMAP.local_to_map(mouse_position)
		
		TILEMAP.set_cell(tile_spawn, ground_level, Brick_Block)
	if Input.is_action_just_pressed("ui_focus_next"):
		if ChangeBLock:
			Brick_Block = Vector2i(0, 0)
		else:
			Brick_Block = Vector2i(1, 1)
		ChangeBLock = !ChangeBLock
	
	pass
