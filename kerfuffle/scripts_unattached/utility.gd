extends RefCounted

class_name Utility

static func circumcise(value: float) -> String:
	return str(int(value))

static func circumcise_floor(value: float) -> String:
	return str(int(floor(value)))

static func circumcise_round(value: float) -> String:
	return str(int(round(value)))
	
static func circumcise_lenient(value: float) -> String:
	if value == floor(value):
		return str(int(value))
	return str(value)
