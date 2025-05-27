extends Camera2D

# Zoom speed (how fast zoom changes)
@export var zoom_speed: float = 10
# Min/Max zoom limits
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0

func _process(delta: float) -> void:
	# --- Zoom Control (Q/E) ---
	if Input.is_action_pressed("zoom_in"):   # E
		zoom -= Vector2(zoom_speed, zoom_speed) * delta
	if Input.is_action_pressed("zoom_out"):  # Q
		zoom += Vector2(zoom_speed, zoom_speed) * delta
	
	# Clamp zoom to min/max values
	zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
