extends Control

func _ready() -> void:
	PlayerData.max_hearts_changed.connect(update_heartbar)
	PlayerData.current_hearts_changed.connect(update_heartbar)

func _process(_delta: float) -> void:
	pass

func update_heartbar() -> void:
	var max_hearts: float = PlayerData.get_max_hearts()
	var current_hearts: float = PlayerData.get_current_hearts()
	
	var result: Array = []

	for i in range(int(max_hearts)):
		if i < current_hearts:
			result.append("Whole")
		elif current_hearts - current_hearts == 0.5 and i == current_hearts:
			result.append("Half")
		else:
			result.append("Empty")
	
	print(result)
