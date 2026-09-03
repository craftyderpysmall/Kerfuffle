extends Resource
class_name ItemData

@export var id: String # base.item.mushroom_1
@export var display_name: String # Magic Mushroom
@export var icon: Texture2D
@export var stack_limit: int = 1  # -1 = unlimited

@export var stat_effects: Array[String] = []
@export var screen_effects: Array[String] = []

func _ready() -> void:
	pass
