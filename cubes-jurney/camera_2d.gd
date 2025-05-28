extends Camera2D

@export var zoom_speed: float = 10
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0
@export var zoom_lerp_speed: float = 5.0  # Controls delay/smoothness

var target_zoom: Vector2

@export var follow_target: NodePath  # Drag your player node here in the inspector
@export var follow_speed: float = 5.0  # Higher = faster camera movement

var target_node: Node2D

func _ready():
	# Start with the current zoom
	target_zoom = zoom
	target_node = get_node(do the player here)

func _process(delta: float) -> void:
	# --- Zoom Control (Q/E) ---
	if Input.is_action_pressed("zoom_in"):   # E
		target_zoom -= Vector2(zoom_speed, zoom_speed) * delta
	if Input.is_action_pressed("zoom_out"):  # Q
		target_zoom += Vector2(zoom_speed, zoom_speed) * delta
	
	# Clamp target zoom to min/max values
	target_zoom = target_zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
	
	# Smoothly interpolate current zoom toward target zoom
	zoom = zoom.lerp(target_zoom, delta * zoom_lerp_speed)
	
	if target_node:
		# Interpolate the camera's position toward the target
		global_position = global_position.lerp(target_node.global_position, delta * follow_speed)
