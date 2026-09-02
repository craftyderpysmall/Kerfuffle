extends Node2D

@export var color_top: Color = Color(0.85, 0.3, 0.3)
@export var color_right: Color = Color(0.3, 0.75, 0.35)
@export var color_bottom: Color = Color(0.3, 0.45, 0.85)
@export var color_left: Color = Color(0.9, 0.8, 0.25)
@export var line_color: Color = Color.WHITE
@export var line_width: float = 3.0

@onready var player: CharacterBody2D = $".."

var quadrants_enabled := false
var quadrant_buffer_radius: float = 0

func _ready() -> void:
	get_viewport().size_changed.connect(queue_redraw)
	queue_redraw()
	
	quadrant_buffer_radius = player.quadrant_buffer_radius
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_key"):
		quadrants_enabled = not quadrants_enabled
		queue_redraw()

func _process(_delta: float) -> void:
	if quadrants_enabled:
		queue_redraw()

func _draw() -> void:
	if not quadrants_enabled:
		return
	
	var top_left := Vector2(-7680 / 2, -7680 / 2)
	var top_right := Vector2(7680 / 2, -7680 / 2)
	var bottom_left := Vector2(-7680 / 2, 7680 / 2)
	var bottom_right := Vector2(7680 / 2, 7680 / 2)
	var center := Vector2(0, 0)

	draw_polygon(PackedVector2Array([top_left, top_right, center]), PackedColorArray([color_top]))
	draw_polygon(PackedVector2Array([top_right, bottom_right, center]), PackedColorArray([color_right]))
	draw_polygon(PackedVector2Array([bottom_right, bottom_left, center]), PackedColorArray([color_bottom]))
	draw_polygon(PackedVector2Array([bottom_left, top_left, center]), PackedColorArray([color_left]))

	draw_line(top_left, bottom_right, line_color, line_width)
	draw_line(top_right, bottom_left, line_color, line_width)
	
	draw_arc(center, quadrant_buffer_radius, 0, TAU, 64, line_color, line_width)
