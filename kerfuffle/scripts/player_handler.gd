extends CharacterBody2D

@export var speed := 320.0
@export var lean_amount := 4.0
@export var lean_speed := 6.0
@export var quadrant_buffer_radius := 35.0

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var camera_2d: Camera2D = $"../Camera2D"

var direction : Vector2 = Vector2.ZERO
var camera_lean := Vector2.ZERO
var cursor_quadrant := 3

func _process(delta: float) -> void:
	play_camera_lean(direction, delta)
	cursor_quadrant = get_quadrant(get_global_mouse_position(), global_position, cursor_quadrant)

func _physics_process(_delta: float) -> void:
	listen_movement()
	move_and_slide()

func listen_movement() -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	# Call animations
	if direction != Vector2.ZERO: # Moving
		play_anim("move")
	else: # Idle
		play_anim("idle")
		
func play_anim(movement_state : String) -> void:
	if cursor_quadrant == 1: # Up
		player_sprite.play(movement_state + "U") 
	elif cursor_quadrant == 2: # Right
		player_sprite.flip_h = false
		player_sprite.play(movement_state + "R")
	elif cursor_quadrant == 3: # Down
		player_sprite.play(movement_state + "D")
	elif cursor_quadrant == 4: # Left
		player_sprite.flip_h = true
		player_sprite.play(movement_state + "R")

func play_camera_lean(dir: Vector2, delta: float) -> void:
	var target_lean := dir * lean_amount
	camera_lean = camera_lean.lerp(target_lean, 1.0 - exp(-lean_speed * delta))
	camera_2d.offset = camera_lean

# Mouse quadrants

#func _input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#
			#print("Quadrant: ", cursor_quadrant)

func get_quadrant(pos: Vector2, center: Vector2, last_quadrant: int) -> int:
	var relative := pos - center
	
	# Inside the dead zone -> don't change quadrant, just keep the last one
	if relative.length() < quadrant_buffer_radius:
		return last_quadrant
	
	var above_slash := relative.y < -relative.x # Is above the "/" diagonal?
	var above_backslash := relative.y < relative.x # Is above the "\" diagonal?
	
	if above_slash and above_backslash:
		return 1 # Top
	elif not above_slash and above_backslash:
		return 2 # Right
	elif not above_slash and not above_backslash:
		return 3 # Bottom
	else:
		return 4 # Left
		
