extends Node2D

@export var enemy_name: String = "Enemy"
@export var max_health: int = 30
@export var skills: Array[Dictionary] = [
	{"name": "Attack1", "damage": 10},
	{"name": "Attack2", "damage": 10},
	{"name": "Attack3", "damage": 10}
]

var current_health: int

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		# TODO: die
		pass
