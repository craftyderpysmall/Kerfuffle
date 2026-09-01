extends Resource
class_name PlayerStats

# --- Base ---
@export var base_max_hearts := 5.0
@export var base_damage := 0.5
@export var base_speed := 320.0
@export var base_armor := 0.0

# --- Effective ---
var max_hearts: float
var damage: float
var speed: float
var armor: float

# --- Current state ---
var current_hearts: float

var on_hit_effects: Array[Callable] = []

func reset_to_base() -> void:
	max_hearts = base_max_hearts
	damage = base_damage
	speed = base_speed
	armor = base_armor
	on_hit_effects.clear()

func recalculate(inventory: Dictionary) -> void:
	var old_max_hearts = max_hearts
	reset_to_base()
	for item in inventory:
		item.apply_effect(self, inventory[item])
	# if max_hp went up, current_hp should rise with it (RoR2 does this);
	# if it's the very first calculation, start at full
	if old_max_hearts == 0.0:
		current_hearts = max_hearts
	else:
		current_hearts += (max_hearts - old_max_hearts)
