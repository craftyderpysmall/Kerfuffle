extends Node

var items_by_id: Dictionary = {}

func _ready() -> void:
	load_all_items("res://items/")

func load_all_items(folder_path: String) -> void:
	var dir := DirAccess.open(folder_path)
	if dir == null:
		push_error("Could not open folder: " + folder_path)
		return

	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.get_extension() == "tres":
			var item: ItemData = load(folder_path.path_join(file_name))
			if item != null:
				items_by_id[item.id] = item
		file_name = dir.get_next()
	dir.list_dir_end()

func get_item_from_id(id: String) -> ItemData:
	return items_by_id.get(id)
