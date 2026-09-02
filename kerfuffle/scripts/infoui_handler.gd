extends Control

@onready var heart_bar: HFlowContainer = $StatsContainer/HeartBar

const heart_scene = preload("res://scenes/heart_ui.tscn")
const heart_full = preload("res://assets/heart_full.png")
const heart_half = preload("res://assets/heart_half.png")
const heart_empty = preload("res://assets/heart_empty.png")

func _ready() -> void:
	draw_heartbar()
	PlayerData.max_hearts_changed.connect(draw_heartbar)
	PlayerData.current_hearts_changed.connect(draw_heartbar)

func draw_heartbar() -> void:
	for child in heart_bar.get_children():
		child.queue_free()
	
	var hearts: Array = calculate_hearts()
	
	for i in hearts:
		var heart_instance = heart_scene.instantiate()
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
