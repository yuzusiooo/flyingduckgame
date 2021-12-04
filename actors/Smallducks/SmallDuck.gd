extends Node2D

var speed = 300
var par
var base_pos : Vector2
var offset : Vector2
var shoot = true
var pellet = preload("res://actors/Duck/Pellet.tscn")
enum states { normal, ouch }
var state = states.normal
func _ready():
	pass
func _physics_process(delta):
	if (state == states.normal):
		base_pos.x = par.global_position.x + offset.x; base_pos.y = par.global_position.y + offset.y
		if (global_position.distance_to(base_pos) > 5.0):
			var ang = get_angle_to(base_pos)
			position += Vector2.RIGHT.rotated(ang) * speed * delta
		if (shoot):
			var p_ins = pellet.instance()
			get_tree().get_current_scene().add_child(p_ins)
			p_ins.global_position = $ShootPoint.global_position
			$Sprite/HeadAnim.play("HeadShoot")
			shoot = false; $ShootTimer.start($ShootTimer.wait_time)
	if (state == states.ouch):
		var screen = get_viewport_rect().size
		position += Vector2.DOWN * speed * delta
		if position.y > screen.y: queue_free()
	pass

func set_new(parent):
	par = parent
	global_position = par.global_position
	offset.x += rand_range(-200, 200); offset.y += rand_range(-200, 200)

func got_hit():
	print("oh no!")
	state = states.ouch
	pass

func _on_ShootTimer_timeout():
	shoot = true; $Sprite/HeadAnim.play("HeadIdle")
