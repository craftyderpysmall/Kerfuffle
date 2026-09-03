extends Resource

class_name PlayerInventory

@export var items_slots: int = 10

var items: Array[ItemData] = []

func reset() -> void:
	items.clear()
