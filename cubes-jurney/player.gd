extends Sprite2D

var WAIT = 0
var rel_pos = Vector2.ZERO
var curr_room = Vector2(0, 1)

func _process(delta: float) -> void:
	# --- WASD Movement ---
	var movement = Vector2.ZERO
	
	if WAIT <= 0:
		if Input.is_action_pressed("ui_right") and checkCollision(rel_pos.x+1, rel_pos.y):  # D
			movement.x += 32
			rel_pos.x += 1
			WAIT = 30
		if Input.is_action_pressed("ui_left") and checkCollision(rel_pos.x-1, rel_pos.y):   # A
			movement.x -= 32
			rel_pos.x -= 1
			WAIT = 30
		if Input.is_action_pressed("ui_down") and checkCollision(rel_pos.x, rel_pos.y+1):   # S
			movement.y += 32
			rel_pos.y += 1
			WAIT = 30
		if Input.is_action_pressed("ui_up") and checkCollision(rel_pos.x, rel_pos.y-1):    # W
			movement.y -= 32
			rel_pos.y -= 1
			WAIT = 30
			
	position += movement
	WAIT -= 1


func checkCollision(x, y):

	var map = global map get Vector2
	
	
