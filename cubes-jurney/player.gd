extends Sprite2D

var wait_timer := 0.0
var rel_pos = Vector2.ZERO
var curr_room = Vector2(0, 1)

const MOVE_INTERVAL := 0.2  # Seconds between moves (adjust as needed)

func _process(delta: float) -> void:
	var movement = Vector2.ZERO
	
	if wait_timer <= 0.0:
		if Input.is_action_pressed("ui_right") and checkCollision(rel_pos.x+1, rel_pos.y):
			movement.x += 32
			rel_pos.x += 1
			wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_left") and checkCollision(rel_pos.x-1, rel_pos.y):
			movement.x -= 32
			rel_pos.x -= 1
			wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_down") and checkCollision(rel_pos.x, rel_pos.y+1):
			movement.y += 32
			rel_pos.y += 1
			wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_up") and checkCollision(rel_pos.x, rel_pos.y-1):
			movement.y -= 32
			rel_pos.y -= 1
			wait_timer = MOVE_INTERVAL

	position += movement
	wait_timer -= delta

func checkCollision(x, y):
	#var map = GlobalVariables.maps[GlobalVariables[curr_room.x][curr_room.y]]
	var map = GlobalVariables.maps[0]
	# check collision

	return true
