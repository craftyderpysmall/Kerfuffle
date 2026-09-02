extends Node

var stats: PlayerStats
var inventory: Dictionary = {}  # ItemData -> int count

const default_stats_template: PlayerStats = preload("res://autoload/player_stats.tres")

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
	
# Inventory

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

# Inventory

func give_item() -> void:
	pass

func take_item() -> void:
	pass

# Stats

func set_max_hearts(mode: String, value: float) -> void:
	var raw_max_hearts: float = stats.max_hearts
	
	if mode == "fix":
		raw_max_hearts = value
	elif mode == "add":
		raw_max_hearts += value
	elif mode == "multiply":
		raw_max_hearts *= value
	elif mode == "markup":
		raw_max_hearts *= (1 + value)
		
	var cooked_max_hearts: float = snapped(raw_max_hearts, 0.5)
	stats.max_hearts = cooked_max_hearts	
	max_hearts_changed.emit()

func get_max_hearts() -> float:
	return stats.max_hearts
	
func set_damage(mode: String, value: float) -> void:
	var raw_damage: float = stats.damage
	
	if mode == "fix":
		raw_damage = value
	elif mode == "add":
		raw_damage += value
	elif mode == "multiply":
		raw_damage *= value
	elif mode == "markup":
		raw_damage *= (1 + value)
		
	var cooked_damage: float = snapped(raw_damage, 0.1)
	stats.damage = cooked_damage	
	damage_changed.emit()

func get_damage() -> float:
	return stats.damage
	
func set_speed(mode: String, value: float) -> void:
	var raw_speed: float = stats.speed
	
	if mode == "fix":
		raw_speed = value
	elif mode == "add":
		raw_speed += value
	elif mode == "multiply":
		raw_speed *= value
	elif mode == "markup":
		raw_speed *= (1 + value)
		
	var cooked_speed: float = snapped(raw_speed, 0.1)
	stats.speed = cooked_speed	
	speed_changed.emit()

func get_speed() -> float:
	return stats.speed
	
func set_current_hearts(mode: String, value: float) -> void:
	var raw_current_hearts: float = stats.current_hearts
	
	if mode == "fix":
		raw_current_hearts = value
	elif mode == "add":
		raw_current_hearts += value
	elif mode == "multiply":
		raw_current_hearts *= value
	elif mode == "markup":
		raw_current_hearts *= (1 + value)
		
	var cooked_current_hearts: float = snapped(raw_current_hearts, 0.5)
	if cooked_current_hearts <= stats.max_hearts:
		stats.current_hearts = cooked_current_hearts
	else:
		stats.current_hearts = stats.max_hearts
	current_hearts_changed.emit()

func get_current_hearts() -> float:
	return stats.current_hearts
