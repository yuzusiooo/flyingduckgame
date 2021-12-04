extends Node2D

export var speed = 200
export var move_by_self = false
enum states { spawned, canpickup, chaseplayer}
var state = states.canpickup
var microfloat = [1.0]
# 0; rate of pickup increment
var frd
var ducka2d

func _ready():
	pass
func _process(delta):
	frd = delta
	if (move_by_self): position += Vector2.LEFT * speed * delta
	match state:
		states.spawned:
			microfloat[0] -= 0.01
			position += Vector2.ONE.rotated(rotation) * (speed * microfloat[0]) * delta
			if (microfloat[0] <= 0.5):
				state = states.canpickup
		states.canpickup: move_by_self = true
		states.chaseplayer:
			look_at(ducka2d.global_position)
			position += Vector2.ONE.rotated(rotation) * speed * delta
			speed += 1
	pass
func set_new(pickup:bool, pos:Vector2):
	global_position = pos
	if (pickup): state = states.spawned
	var r_angle = rand_range(0, 360)
	rotation = r_angle
	pass
func _on_PickupRange_area_entered(area):
	if (area.name == "Duck_Hitbox"):
		ducka2d = area
		state = states.chaseplayer
	pass
