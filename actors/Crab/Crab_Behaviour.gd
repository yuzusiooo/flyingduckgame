extends Node2D

export var speed = 150

var p
var endpoint = 512
enum states { normal, leaving }
var state = states.normal
var cshoot = true
var bubble = preload("res://actors/Crab/Bubble.tscn")
var leaving_dirset = false
var v = Vector2.ZERO

func _ready():
	pass
func set_new(parent):
	p = parent
	pass
func _update(delta):
# Move to the left
# shooting bubbles on the way until it reaches the end point
# when it reaches the end point, move away from the player and go off screen
	if (state == states.normal):
		p.global_position += Vector2.LEFT * speed * delta
		if ($Sprite/Anim.current_animation != "Shoot" && !cshoot): $Sprite/Anim.play("Loop")
		if (cshoot):
				var b_ins = bubble.instance()
				get_tree().get_current_scene().add_child(b_ins)
				b_ins.set_new(self)
				$ShootTimer.start($ShootTimer.wait_time); cshoot = false
				$Sprite/Anim.play("Shoot")
		if (p.global_position.x <= endpoint): state = states.leaving
	if (state == states.leaving):
# check if it should move to the bottom or the top of the screen
# keep vertical speed the same, while horizontal speed should deminish
		if (!leaving_dirset):
			v = Vector2.LEFT # assumes crab is already moving to the left, so only the vertical axis needs to be added later
			if (p.global_position.y > (get_viewport().size.y)/2): v += Vector2.DOWN
			else: v += Vector2.UP
			leaving_dirset = true
		else:
			p.global_position += v * speed * delta
			v.x += 0.5 * delta
			if (v.x >= 0): v.x = 0
	pass
func _on_ShootTimer_timeout():
	cshoot = true; $Sprite/Anim.play("Loop")
