extends Node

var stats: PlayerStats
var inventory: PlayerInventory

const default_stats: PlayerStats = preload("res://scripts_unattached/player_stats.tres")
const default_inventory: PlayerInventory = preload("res://scripts_unattached/player_inventory.tres")

signal max_hearts_changed()
signal damage_changed()
signal speed_changed()
signal luck_changed()
signal current_hearts_changed()
signal items_changed()

func _ready():
	start_new_run()

func start_new_run() -> void:
	stats = default_stats.duplicate()
	inventory = default_inventory.duplicate()
	
	stats.reset()
	inventory.reset()

# Stats

func set_max_hearts(mode: String, value: float = 0, scale: bool = false) -> void:
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
	
	if scale == true:
		var ratio: float = stats.current_hearts / stats.max_hearts
		stats.current_hearts = max(snapped(cooked_max_hearts * ratio, 0.5), 0.5)
	if cooked_max_hearts < stats.current_hearts:
		stats.current_hearts = cooked_max_hearts
	stats.max_hearts = cooked_max_hearts
	
	max_hearts_changed.emit()

func get_max_hearts() -> float:
	return stats.max_hearts
	
func set_damage(mode: String, value: float = 0) -> void:
	var raw_damage: float = stats.damage
	
	if mode == "fix":
		raw_damage = value
	elif mode == "add":
		raw_damage += value
	elif mode == "multiply":
		raw_damage *= value
	elif mode == "markup":
		raw_damage *= (1 + value)
		
	var cooked_damage: float = snapped(raw_damage, 0.5)
	stats.damage = cooked_damage	
	damage_changed.emit()

func get_damage() -> float:
	return stats.damage
	
func set_speed(mode: String, value: float = 0) -> void:
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

func set_luck(mode: String, value: float = 0) -> void:
	var raw_luck: float = stats.luck
	
	if mode == "fix":
		raw_luck = value
	elif mode == "add":
		raw_luck += value
	elif mode == "multiply":
		raw_luck *= value
	elif mode == "markup":
		raw_luck *= (1 + value)
	
	var cooked_luck: float = snapped(raw_luck, 0.1)
	stats.luck = cooked_luck
	luck_changed.emit()
	
func get_luck() -> float:
	return stats.luck

func set_current_hearts(mode: String, value: float = 0) -> void:
	var raw_current_hearts: float = stats.current_hearts
	
	if mode == "fix":
		raw_current_hearts = value
	elif mode == "add":
		raw_current_hearts += value
	elif mode == "multiply":
		raw_current_hearts *= value
	elif mode == "markup":
		raw_current_hearts *= (1 + value)
	elif mode == "max":
		raw_current_hearts = stats.max_hearts
		
	var cooked_current_hearts: float = snapped(raw_current_hearts, 0.5)
	
	if cooked_current_hearts <= stats.max_hearts:
		stats.current_hearts = cooked_current_hearts
	else:
		stats.current_hearts = stats.max_hearts
		
	current_hearts_changed.emit()

func get_current_hearts() -> float:
	return stats.current_hearts

# Bridge

func apply_effects(item: ItemData) -> void:
	for effect in item.stat_effects:
		var tokens = effect.split(" ")
		var func_name = tokens[0]
		var args = []
		for i in range(1, tokens.size()):
			var token = tokens[i]
			if token == "true":
				args.append(true)
			elif token == "false":
				args.append(false)
			elif token.is_valid_int():
				args.append(int(token))
			elif token.is_valid_float():
				args.append(token.to_float())
			else:
				args.append(token)
		
		if has_method(func_name): callv(func_name, args)

func recalculate_stats() -> void:
	var saved_current_heart_ratio: float = stats.current_hearts / stats.max_hearts
	
	stats.reset()
	
	for item in inventory.items:
		apply_effects(item)
	
	stats.current_hearts = snapped(stats.max_hearts * saved_current_heart_ratio, 0.5)
	current_hearts_changed.emit()

# Inventory

func give_item(item: Variant) -> void:
	var target_item: ItemData
	
	if item is ItemData:
		target_item = item
	elif typeof(item) == TYPE_STRING:
		target_item = ItemDatabase.get_item_from_id(item)
		
	inventory.items.push_back(target_item)
	recalculate_stats()
	items_changed.emit()

func take_item(item: Variant) -> void:
	var target_item: ItemData
	
	if item is ItemData:
		target_item = item
	elif typeof(item) == TYPE_STRING:
		target_item = ItemDatabase.get_item_from_id(item)
	
	inventory.items.erase(target_item)
	recalculate_stats()
	items_changed.emit()

func take_all(item: Variant) -> void:
	var target_item: ItemData
	
	if item is ItemData:
		target_item = item
	elif typeof(item) == TYPE_STRING:
		target_item = ItemDatabase.get_item_from_id(item)
	
	inventory.items = inventory.items.filter(func(i): return i != target_item)
	recalculate_stats()
	items_changed.emit()

func has_item(item: Variant) -> bool:
	var target_item: ItemData
	
	if item is ItemData:
		target_item = item
	elif typeof(item) == TYPE_STRING:
		target_item = ItemDatabase.get_item_from_id(item)
		
	return inventory.items.has(target_item)

func count_item(item: Variant) -> int:
	var target_item: ItemData
	
	if item is ItemData:
		target_item = item
	elif typeof(item) == TYPE_STRING:
		target_item = ItemDatabase.get_item_from_id(item)
	
	return inventory.items.count(target_item)
