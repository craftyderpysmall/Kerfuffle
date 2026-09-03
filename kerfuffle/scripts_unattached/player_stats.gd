extends Resource

class_name PlayerStats

# --- Base ---
@export var base_max_hearts: float = 5.0
@export var base_damage: float = 0.5
@export var base_speed: float = 320.0

# --- Effective ---
var max_hearts: float
var damage: float
var speed: float

# --- Current state ---
var current_hearts: float

var on_hit_effects: Array[Callable] = []

func reset() -> void:
	max_hearts = base_max_hearts
	damage = base_damage
	speed = base_speed
	current_hearts = base_max_hearts
	on_hit_effects.clear()
