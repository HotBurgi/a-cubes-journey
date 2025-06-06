extends Sprite2D

@export var healt: int = 100

var wait_timer := 0.0
var rel_pos = Vector2(5,5)
var curr_room = Vector2(0, 1)

var map = GlobalVariables.maps[GlobalVariables.MAP[curr_room.x][curr_room.y]]

var curr_tile = map[rel_pos.x][rel_pos.y]
var last_key_pressed = ""

const MOVE_INTERVAL := 0.2  # Seconds between moves (adjust as needed)
var special_delay_triggered := false # Crea la variabile e assegna implicitamente il type

func _process(delta: float) -> void:
	if curr_tile == 5 and not special_delay_triggered:
		wait_timer = 2
		special_delay_triggered = true
		return
	elif curr_tile != 5:
		special_delay_triggered = false
		
	var movement = Vector2.ZERO
	var room_to_check = curr_room
	
	if wait_timer <= 0.0:
		if Input.is_action_pressed("ui_right") and checkCollision(rel_pos.x+1, rel_pos.y, room_to_check):
			last_key_pressed = "ui_right"
			if curr_tile == 7:
				room_to_check.y += 1
			if checkCollision(rel_pos.x+1, rel_pos.y, room_to_check):
				if curr_tile == 7:
					rel_pos.x = -1
					curr_room.y += 1
				movement.x += 32
				rel_pos.x += 1
				wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_left"):
			last_key_pressed = "ui_left"
			if curr_tile == 9:
				room_to_check.y -= 1
			if checkCollision(rel_pos.x-1, rel_pos.y, room_to_check):
				if curr_tile == 9:
					rel_pos.x = 11
					curr_room.y -= 1
				movement.x -= 32
				rel_pos.x -= 1
				wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_down"):
			last_key_pressed = "ui_down"
			if curr_tile == 8:
				room_to_check.x -= 1
			if checkCollision(rel_pos.x, rel_pos.y+1, room_to_check):
				if curr_tile == 8:
					rel_pos.y = -1
					curr_room.x -= 1 
				movement.y += 32
				rel_pos.y += 1
				wait_timer = MOVE_INTERVAL
		elif Input.is_action_pressed("ui_up"):
			last_key_pressed = "ui_up"
			if curr_tile == 6:
				room_to_check.x += 1
			if checkCollision(rel_pos.x, rel_pos.y-1, room_to_check):
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

func checkCollision(x, y, croom):
	x = posmod(x, 11)
	y = posmod(y, 11)
	
	map = GlobalVariables.maps[GlobalVariables.MAP[croom.x][croom.y]]
	# check collision
	print(map[x][y])
	if(map[x][y] == 5 and curr_tile == 5):
		return true
	if((map[x][y] == 1) or (map[x][y] == 5 and last_key_pressed != "ui_up") or (curr_tile == 5 and last_key_pressed == "ui_up")):
		return false
	return true

func posmod(n: int, m: int) -> int:
	return ((n % m) + m) % m
