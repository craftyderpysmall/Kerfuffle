extends Node

func _ready() -> void:
	LimboConsole.register_command(PlayerData.set_max_hearts, "set_max_hearts", "")
	LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.get_max_hearts())), "get_max_hearts", "")
	LimboConsole.register_command(PlayerData.set_damage, "set_damage", "")
	LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.get_damage())), "get_damage", "")
	LimboConsole.register_command(PlayerData.set_speed, "set_speed", "")
	LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.get_speed())), "get_speed", "")
	LimboConsole.register_command(PlayerData.set_luck, "set_luck", "")
	LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.get_luck())), "get_luck", "")
	LimboConsole.register_command(PlayerData.set_current_hearts, "set_current_hearts", "")
	LimboConsole.register_command(func(): LimboConsole.info(str(PlayerData.get_current_hearts())), "get_current_hearts", "")
	
	LimboConsole.register_command(PlayerData.give_item, "give_item", "")
	LimboConsole.register_command(PlayerData.take_item, "take_item", "")
	LimboConsole.register_command(PlayerData.take_all, "take_all", "")
	LimboConsole.register_command(func(item: String): LimboConsole.info(str(PlayerData.has_item(item))), "has_item", "")
	LimboConsole.register_command(func(item: String): LimboConsole.info(str(PlayerData.count_item(item))), "count_item", "")
