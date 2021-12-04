extends KinematicBody2D

export var speed = 450
var grav = 75
var act_grav = Vector2.ZERO
var shift_mod = 1

var shoot = true
var shootTime = 0.5
var pellet = preload("res://actors/Duck/Pellet.tscn")

enum states { normal, dead, ouch }
var state = states.normal

var bread = 0
var egg = 0
var ehp = 1
var smallducks = []

var stagepar

func _ready():
	pass

func _physics_process(delta):
	set_text()
	if (state != states.dead):
	#	movement, player will gradually move down if no vertical inputs are pressed
		var velocity = Vector2.ZERO
		if Input.is_action_pressed("key_up"):
			velocity.y -= 1.0; act_grav = Vector2.ZERO
		if Input.is_action_just_released("key_up"): $Freefly_Timer.start(0.5)
		if (!Input.is_action_pressed("key_up")): act_grav.y += 0.01
		act_grav.y = clamp(act_grav.y, 0.0, 1.0)
		if Input.is_action_pressed("key_down"): velocity.y += 1.0
		if Input.is_action_pressed("key_left"): velocity.x -= 1.0
		if Input.is_action_pressed("key_right"): velocity.x += 1.0
		if Input.is_action_pressed("key_shift"): shift_mod = 0.5
		else: shift_mod = 1
		velocity = velocity.normalized()
		velocity = move_and_slide(velocity)
		position += velocity * speed * delta * shift_mod
		position.y += act_grav.y * grav * delta
	#	Shooting
		if (Input.is_action_pressed("key_a") && shoot):
			var p_inst = pellet.instance()
			get_tree().get_current_scene().add_child(p_inst)
			p_inst.set_new(self)
			p_inst.global_position = $ShootPoint.global_position
			$Sprite/HeadAnim.play("HeadShoot")
			shoot = false;
			if (shift_mod == 0): $ShootTimer.start(shootTime/2)
			else: $ShootTimer.start(shootTime)
			pass
		position.x = clamp(position.x, 0, get_viewport_rect().size.x)
		position.y = clamp(position.y, 0, get_viewport_rect().size.y)
#	Check if alive
	if (state == states.dead):
		position.y += act_grav.y * grav * delta
		grav += (5)
	pass

func set_text():
	$BreadCounter.text = String(bread); $EggCounter.text = String(egg); pass

func _on_ShootTimer_timeout():
	shoot = true; $Sprite/HeadAnim.play("HeadIdle")

func _on_Freefly_Timer_timeout(): act_grav.y = 1.0; pass

func _on_Duck_Hitbox_area_entered(area):
	if (area.name == "Bubble_Hitbox" and state == states.normal):
		ehp -= 1
		iframe()
		if (egg > 0):
			smallducks[smallducks.size()-1].got_hit()
			smallducks.remove(smallducks.size()-1)
			egg -= 1

		area.get_parent().queue_free()
		if (ehp <= 0):
			state = states.dead
			stagepar.duck_defeated()
	if (area.name == "Bread_Hitbox"):
		get_bread(); area.get_parent().queue_free()
	if (area.name == "Egg_Hitbox"):
		get_egg(); area.get_parent().queue_free()
	pass # Replace with function body.

func get_bread():
	bread += 1
	stagepar.bread += 1
	add_score(100)

func get_egg():
	egg += 1
	stagepar.eggs += 1
	ehp += 1
#	Make a new small duck
	var sduck_ins = preload("res://actors/Smallducks/SmallDuck.tscn").instance()
	get_tree().get_current_scene().add_child(sduck_ins)
	sduck_ins.set_new(self)
#	add new duck into smallduck list for tracking
	smallducks.append(sduck_ins)
	add_score(500)

func iframe():
	modulate.a = 0.5; state = states.ouch
	$iframe_timer.start($iframe_timer.wait_time)
	pass

func _on_iframe_timer_timeout():
	if (state != states.dead):
		modulate.a = 1; state = states.normal
	pass

func add_score(score):
	stagepar.add_score(score)
