extends Sprite2D

var wait_timer := 0.0
var rel_pos = Vector2(5,5)
var curr_room = Vector2(0, 1)

var map = GlobalVariables.maps[GlobalVariables.MAP[curr_room.x][curr_room.y]]

var curr_tile = map[rel_pos.x][rel_pos.y]

const MOVE_INTERVAL := 0.2  # Seconds between moves (adjust as needed)

func _process(delta: float) -> void:
	var movement = Vector2.ZERO
	
	if wait_timer <= 0.0:
		if Input.is_action_pressed("ui_right") and checkCollision(rel_pos.x+1, rel_pos.y):
			if curr_tile == 7:
				rel_pos.x = -1
				curr_room.y += 1
			movement.x += 32
			rel_pos.x += 1
			wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_left") and checkCollision(rel_pos.x-1, rel_pos.y):
			if curr_tile == 9:
				rel_pos.x = 11
				curr_room.y -= 1
			movement.x -= 32
			rel_pos.x -= 1
			wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_down") and checkCollision(rel_pos.x, rel_pos.y+1):
			if curr_tile == 8:
				rel_pos.y = -1
				curr_room.x -= 1 
			movement.y += 32
			rel_pos.y += 1
			wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_up") and checkCollision(rel_pos.x, rel_pos.y-1):
			if curr_tile == 6:
				rel_pos.y = 11
				curr_room.x += 1
			movement.y -= 32
			rel_pos.y -= 1
			wait_timer = MOVE_INTERVAL
			
	position += movement
	curr_tile = map[rel_pos.x][rel_pos.y]
	var map = GlobalVariables.maps[GlobalVariables.MAP[curr_room.x][curr_room.y]]
	wait_timer -= delta

func checkCollision(x, y):
	x = int(x) % 11
	y = int(y) % 11
	
	map = GlobalVariables.maps[GlobalVariables.MAP[curr_room.x][curr_room.y]]
	# check collision
	if(map[x][y] != 0 and !(map[x][y] >= 6 and map[x][y] <= 9)):
		return false
	return true
