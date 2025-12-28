extends Node2D
@onready var TILEMAP: TileMapLayer = $TileMapLayer

var ground_level = 0
var Brick_Block: Vector2i = Vector2i(0, 0)
var ChangeBLock: bool = false
const MAPID = 0
var data = {
	"id": MAPID,
	"map": []
}

func _process(_delta: float) -> void:
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
		print("ui_JSON_test: Action_pressed")
		for cell in TILEMAP.get_used_cells():
			var _atlas = TILEMAP.get_cell_atlas_coords(cell)
			data["map"].append({
				"pos": [cell.x, cell.y],
				"type_block": {
					"atlas": [_atlas.x, _atlas.y]
				}
			})
		var file = FileAccess.open("res://Data/Map/Map.json", FileAccess.WRITE)
		file.store_string(JSON.stringify(data, "\t"))
		file.close()
	if Input.is_action_just_pressed("ui_JSON_test_2"):
		var file = FileAccess.open("res://Data/Map/Map.json", FileAccess.READ)
		var text = file.get_as_text()
		var data = JSON.parse_string(text)

		TILEMAP.clear()
		for cell_data in data["map"]:
			var pos = Vector2i(cell_data["pos"][0], cell_data["pos"][1])
			var atlas = Vector2i(
				cell_data["type_block"]["atlas"][0],
				cell_data["type_block"]["atlas"][1]
				)

			TILEMAP.set_cell(pos, 0, atlas)

		file.close()
