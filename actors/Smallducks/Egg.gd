extends Node2D

export var speed = 150
export var obtainable = true
var crab_pos

func _ready():
	pass
func _physics_process(delta):
	if (obtainable):
		position += Vector2.LEFT * speed * delta
	$Egg_Hitbox.monitorable = obtainable
func set_new(obt):
	obtainable = obt
