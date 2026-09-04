extends Control

@onready var heart_bar: HFlowContainer = $StatsContainer/HeartBar
@onready var damage_label: Label = $StatsContainer/MiscStatsBar/Damage/Label
@onready var speed_label: Label = $StatsContainer/MiscStatsBar/Speed/Label
@onready var luck_label: Label = $StatsContainer/MiscStatsBar/Luck/Label


const ui_icon = preload("res://scenes/ui_icon.tscn")
const heart_full = preload("res://assets/heart_full.png")
const heart_half = preload("res://assets/heart_half.png")
const heart_empty = preload("res://assets/heart_empty.png")

func _ready() -> void:
	draw_heartbar()
	draw_misc_stats_bar()
	PlayerData.max_hearts_changed.connect(draw_heartbar)
	PlayerData.current_hearts_changed.connect(draw_heartbar)
	PlayerData.damage_changed.connect(draw_misc_stats_bar)
	PlayerData.speed_changed.connect(draw_misc_stats_bar)
	PlayerData.luck_changed.connect(draw_misc_stats_bar)

func draw_misc_stats_bar() -> void:
	damage_label.text = Utility.circumcise_lenient(PlayerData.get_damage())
	speed_label.text = Utility.circumcise_floor(PlayerData.get_speed())
	luck_label.text = Utility.circumcise_lenient(PlayerData.get_luck())

func draw_heartbar() -> void:
	for child in heart_bar.get_children():
		child.queue_free()
	
	var hearts: Array = calculate_hearts()
	
	for i in hearts:
		var heart_instance = ui_icon.instantiate()
		heart_bar.add_child(heart_instance)
		
		if i == "Whole":
			heart_instance.texture = heart_full
		elif i == "Half":
			heart_instance.texture = heart_half
		elif i == "Empty":
			heart_instance.texture = heart_empty

func calculate_hearts() -> Array:
	var max_hearts: float = PlayerData.get_max_hearts()
	var current_hearts: float = PlayerData.get_current_hearts()
	
	var result: Array = []

	for i in range(int(max_hearts)):
		if i < (current_hearts - 0.5):
			result.append("Whole")
		elif current_hearts - i == 0.5:
			result.append("Half")
		else:
			result.append("Empty")
			
	return result
