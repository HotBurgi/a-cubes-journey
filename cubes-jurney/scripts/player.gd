extends Sprite2D

var wait_timer := 0.0
var rel_pos = Vector2(5,5)
var curr_room = Vector2(0, 1)

#var map = GlobalVariables.maps[GlobalVariables[curr_room.x][curr_room.y]]
var map = GlobalVariables.maps[0]

var curr_tile = map[rel_pos.x][rel_pos.y]

const MOVE_INTERVAL := 0.2  # Seconds between moves (adjust as needed)

func _process(delta: float) -> void:
	var movement = Vector2.ZERO
	
	if wait_timer <= 0.0:
		if Input.is_action_pressed("ui_right") and checkCollision(rel_pos.x+1, rel_pos.y):
			if curr_tile == 7:
				rel_pos.x = -1
				curr_room.y += 1
				#var map = GlobalVariables.maps[GlobalVariables[curr_room.x][curr_room.y]]
				var map = GlobalVariables.maps[0]
			movement.x += 32
			rel_pos.x += 1
			wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_left") and checkCollision(rel_pos.x-1, rel_pos.y):
			if curr_tile == 9: # Metti giusto
				rel_pos.x = 11
				curr_room.y -= 1
				#var map = GlobalVariables.maps[GlobalVariables[curr_room.x][curr_room.y]]
				var map = GlobalVariables.maps[0]
			movement.x -= 32
			rel_pos.x -= 1
			wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_down") and checkCollision(rel_pos.x, rel_pos.y+1):
			if curr_tile == 8: # Metti giusto
				rel_pos = Vector2(0,0) # Metti le coordinate giuste
				#aggiorna var map copia incollando il commento sopra (lascialo commentato anche qui)
			movement.y += 32
			rel_pos.y += 1
			wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_up") and checkCollision(rel_pos.x, rel_pos.y-1):
			if curr_tile == 6: # Metti giusto
				rel_pos = Vector2(0,0) # Metti le coordinate giuste
				#aggiorna var map copia incollando il commento sopra (lascialo commentato anche qui)
			movement.y -= 32
			rel_pos.y -= 1
			wait_timer = MOVE_INTERVAL

	print(rel_pos.x, " - ", rel_pos.y)
	position += movement
	curr_tile = map[rel_pos.x][rel_pos.y]
	wait_timer -= delta

func checkCollision(x, y):
	x = int(x) % 11
	y = int(y) % 11
	#map = GlobalVariables.maps[GlobalVariables[curr_room.x][curr_room.y]]
	map = GlobalVariables.maps[0]
	# check collision
	if(map[x][y] != 0 and !(map[x][y] >= 6 and map[x][y] <= 9)):
		return false
	return true
