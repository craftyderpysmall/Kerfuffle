extends Node

var stats: PlayerStats
var inventory: Dictionary = {}  # ItemData -> int count

const default_stats_template := "res://player/player_stats.tres"

#func start_new_run() -> void:
	#stats = default_stats_template.duplicate()
	#inventory.clear()
	#stats.reset_to_base()
	#stats.current_hp = stats.max_hp
#
#func add_item(item: ItemData) -> void:
	#inventory[item] = inventory.get(item, 0) + 1
	#stats.recalculate(inventory)
#
#func has_item(item: ItemData) -> bool:
	#return inventory.has(item)
#
#func get_item_count(item: ItemData) -> int:
	#return inventory.get(item, 0)

# Inventory

#func add_item(item: ItemData) -> void:
	#inventory[item] = inventory.get(item, 0) + 1
	#recalculate_stats()
#
#func recalculate_stats() -> void:
	#stats.reset_to_base()
	#for item in inventory:
		#item.apply_effect(stats, inventory[item])
