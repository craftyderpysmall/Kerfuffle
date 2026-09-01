extends Resource
class_name ItemData

@export var id: String # base.item.mushroom_1
@export var display_name: String # Magic Mushroom
@export var icon: Texture2D
@export var stack_limit: int = -1  # -1 = unlimited

# Called once per stack, whenever inventory is recalculated
func apply_effect(stats: PlayerStats, stack_count: int) -> void:
	pass  # base does nothing; children override this
