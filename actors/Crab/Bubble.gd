extends Node2D

var player
export var speed = 300
var set = false
var p_ang : float

func _ready():
	speed += rand_range(10, 200)
	pass
func _physics_process(delta):
#	var p_ang: float
#	p_ang = Vector2.LEFT.angle_to(player.global_position)
#	position += Vector2.LEFT.rotated(p_ang) * speed * delta
#	var p_ang = (self.global_position * Vector2.RIGHT).angle_to(player.global_position)
#	print(rad2deg(p_ang))
	if (!set): p_ang = get_angle_to(player.global_position); set = true
	position += Vector2.RIGHT.rotated(p_ang) * speed * delta
	speed += (1 * delta)
	pass
func set_new(parent):
	player = get_tree().get_current_scene().find_node("Duck")
	self.global_position = parent.global_position
	pass
