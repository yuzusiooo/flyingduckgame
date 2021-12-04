extends Node2D


func _ready():
	randomize()
	pass

func _physics_process(delta):
	var mod = rand_range(-5, 5)
	position.y += mod
