extends Camera2D

# Movement speed (pixels per second)
@export var move_speed: float = 500.0
# Zoom speed (how fast zoom changes)
@export var zoom_speed: float = 10
# Min/Max zoom limits
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0

func _process(delta: float) -> void:
	# --- WASD Movement ---
	var movement = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):  # D
		movement.x += 1
	if Input.is_action_pressed("ui_left"):   # A
		movement.x -= 1
	if Input.is_action_pressed("ui_down"):   # S
		movement.y += 1
	if Input.is_action_pressed("ui_up"):    # W
		movement.y -= 1
	
	# Normalize diagonal movement to prevent faster speed
	if movement.length() > 0:
		movement = movement.normalized() * move_speed * delta
	
	position += movement
	
	# --- Zoom Control (Q/E) ---
	if Input.is_action_pressed("zoom_in"):   # E
		zoom -= Vector2(zoom_speed, zoom_speed) * delta
	if Input.is_action_pressed("zoom_out"):  # Q
		zoom += Vector2(zoom_speed, zoom_speed) * delta
	
	# Clamp zoom to min/max values
	zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
