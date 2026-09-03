extends Node

func _ready() -> void:
	LimboConsole.register_command(PlayerData.set_max_hearts, "set_max_hearts", "Self Explanatory")
	LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.get_max_hearts())), "get_max_hearts", "Self Explanatory")
	LimboConsole.register_command(PlayerData.set_damage, "set_damage", "Self Explanatory")
	LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.get_damage())), "get_damage", "Self Explanatory")
	LimboConsole.register_command(PlayerData.set_speed, "set_speed", "Self Explanatory")
	LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.get_speed())), "get_speed", "Self Explanatory")
	LimboConsole.register_command(PlayerData.set_current_hearts, "set_current_hearts", "Self Explanatory")
	LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.get_current_hearts())), "get_current_hearts", "Self Explanatory")
	
	LimboConsole.register_command(PlayerData.give_item, "give_item", "Self Explanatory")
	LimboConsole.register_command(PlayerData.take_item, "take_item", "Self Explanatory")
	LimboConsole.register_command(PlayerData.take_all, "take_all", "Self Explanatory")
	#LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.has_item())), "has_item", "Self Explanatory")
	#LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.count_item())), "count_item", "Self Explanatory")
