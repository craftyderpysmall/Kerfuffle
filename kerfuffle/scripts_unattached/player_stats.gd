extends Resource

class_name PlayerStats

# --- Base ---
@export var base_max_hearts: float = 5.0
@export var base_damage: float = 0.5
@export var base_speed: float = 320.0
@export var base_luck: float = 1.0

# --- Effective ---
var max_hearts: float
var damage: float
var speed: float
var luck: float

# --- Current state ---
var current_hearts: float

func reset() -> void:
	max_hearts = base_max_hearts
	damage = base_damage
	speed = base_speed
	luck = base_luck
	current_hearts = base_max_hearts
