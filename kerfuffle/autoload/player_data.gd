extends Node

var stats: PlayerStats
var inventory: Dictionary = {}  # ItemData -> int count

const default_stats_template: PlayerStats = preload("res://player/player_stats.tres")

signal max_hearts_changed()
signal damage_changed()
signal speed_changed()
signal current_hearts_changed()

# ---

func _ready():
	start_new_run()

func start_new_run() -> void:
	stats = default_stats_template.duplicate()
	inventory.clear()
	stats.reset_to_base()
	stats.current_hearts = stats.max_hearts

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
		
# Getters and Setters

func set_max_hearts(mode: String, value: float) -> void:
	if mode == "fix":
		stats.max_hearts = value
	elif mode == "add":
		stats.max_hearts += value
	elif mode == "multiply":
		stats.max_hearts *= value
	elif mode == "markup":
		stats.max_hearts *= (1 + value)
		
	max_hearts_changed.emit()

func get_max_hearts() -> float:
	return stats.max_hearts
	
func set_damage(mode: String, value: float) -> void:
	if mode == "fix":
		stats.damage = value
	elif mode == "add":
		stats.damage += value
	elif mode == "multiply":
		stats.damage *= value
	elif mode == "markup":
		stats.damage *= (1 + value)
		
	damage_changed.emit()

func get_damage() -> float:
	return stats.damage
	
func set_speed(mode: String, value: float) -> void:
	if mode == "fix":
		stats.speed = value
	elif mode == "add":
		stats.speed += value
	elif mode == "multiply":
		stats.speed *= value
	elif mode == "markup":
		stats.speed *= (1 + value)
		
	speed_changed.emit()

func get_speed() -> float:
	return stats.speed
	
func set_current_hearts(mode: String, value: float) -> void:
	if mode == "fix":
		stats.current_hearts = value
	elif mode == "add":
		stats.current_hearts += value
	elif mode == "multiply":
		stats.current_hearts *= value
	elif mode == "markup":
		stats.current_hearts *= (1 + value)
		
	current_hearts_changed.emit()

func get_current_hearts() -> float:
	return stats.current_hearts
