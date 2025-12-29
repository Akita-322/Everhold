extends Node

const MAP_DIR := "res://Data/Map/"

# Сохраняем карту по имени
func save_map(_name: String, tilemap: TileMapLayer) -> bool:
	DirAccess.make_dir_recursive_absolute(MAP_DIR)
	var data = { "map": [] }

	for cell in tilemap.get_used_cells():
		var atlas = tilemap.get_cell_atlas_coords(cell)
		data["map"].append({
			"pos": [cell.x, cell.y],
			"type_block": { "atlas": [atlas.x, atlas.y] }
		})
	
	var path = MAP_DIR + _name + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	if not file:
		return false
	file.store_string(JSON.stringify(data))
	file.close()
	print("save_map: complete")
	return true
	
# Загружаем карту по имени
func load_map(_name: String, tilemap: TileMapLayer) -> bool:
	var path = MAP_DIR + _name + ".json"
	if not FileAccess.file_exists(path):
		return false

	var file = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	

	var data = JSON.parse_string(text)
	if typeof(data) != TYPE_DICTIONARY or not data.has("map"):
		return false

	tilemap.clear()
	for cell_data in data["map"]:
		var pos = Vector2i(cell_data["pos"][0], cell_data["pos"][1])
		var atlas = Vector2i(
			cell_data["type_block"]["atlas"][0],
			cell_data["type_block"]["atlas"][1]
		)
		tilemap.set_cell(pos, 0, atlas)
	print("load_map: complete")
	return true

## Создать новую пустую карту
#func new_map(name: String, tilemap: TileMapLayer):
	#tilemap.clear()
	#save_map(name, tilemap)
