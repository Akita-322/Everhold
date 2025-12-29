extends Node2D
@onready var TILEMAP: TileMapLayer = $TileMapLayer

var ground_level = 0
var Brick_Block: Vector2i = Vector2i(0, 0)
var ChangeBLock: bool = false
const MAP = "Map"


func _ready() -> void:
	MapManager.load_map(MAP, TILEMAP)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_create_object"):
		var mouse_position = get_global_mouse_position()
		var tile_spawn = TILEMAP.local_to_map(mouse_position)
		print(tile_spawn)
		TILEMAP.set_cell(tile_spawn, ground_level, Brick_Block)
		
	if Input.is_action_just_pressed("ui_focus_next"):
		if ChangeBLock:
			Brick_Block = Vector2i(0, 0)
		else:
			Brick_Block = Vector2i(1, 1)
		ChangeBLock = !ChangeBLock
	if Input.is_action_just_pressed("ui_JSON_test"):
		MapManager.save_map(MAP, TILEMAP)
	if Input.is_action_just_pressed("ui_JSON_test_2"):
		MapManager.load_map(MAP, TILEMAP)
