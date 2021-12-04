extends Node2D

var game_started = true
var time = 0.0
var end_time = 75
var crab_inc = 0
enum ef {
	f1x3, f2x3, f2x5_l, f6_wavy
}
var timings = [
	3.0, 6.0, 10.0, 20.0, 25.0, 30.0, 35.0, 40, 42, 50, 55, 60
]
var enemy = [
	ef.f1x3, ef.f1x3, ef.f2x5_l, ef.f2x3, ef.f1x3, ef.f2x3, ef.f1x3, ef.f6_wavy, ef.f6_wavy, ef.f2x3, ef.f2x5_l, ef.f1x3
]

var next_egg = 7.0

var stagepar

func _ready():
	pass

func _process(delta):
	if (game_started):
		time += delta
		$TimeText.text = String(time)
		enemy_spawner()
		egg_spawner()
		if (int(time) == end_time):
			stagepar.game_won()
			print("win")
			time = 0

func enemy_spawner():
	if (crab_inc < timings.size()):
		if (int(time) == int(timings[crab_inc])):
			var ef_ins = get_enemyform().instance()
			get_tree().get_current_scene().add_child(ef_ins)
			ef_ins.global_position = $Spawner.global_position
			crab_inc += 1

func get_enemyform():
#	return the formation
	var check = enemy[crab_inc]
	var r
	match check:
		ef.f1x3: r = preload("res://actors/Crab/Crab Formations/f1x3.tscn")
		ef.f2x3: r = preload("res://actors/Crab/Crab Formations/f2x3.tscn")
		ef.f2x5_l: r = preload("res://actors/Crab/Crab Formations/f2x5_Long.tscn")
		ef.f6_wavy: r = preload("res://actors/Crab/Crab Formations/f6_wavy.tscn")
	return r

#func egg_spawner():
#	if (egg_inc < egg_timer.size()):
#		if (int(time) == int(egg_timer[egg_inc])):
#			var egg_ins = preload("res://actors/Smallducks/Egg.tscn").instance()
#			get_tree().get_current_scene().add_child(egg_ins)
#			egg_ins.global_position = $Spawner.global_position
#			egg_inc += 1
#		pass

func egg_spawner():
	if (int(time) == int(next_egg)):
		var egg_ins = preload("res://actors/Smallducks/Egg.tscn").instance()
		get_tree().get_current_scene().add_child(egg_ins)
		egg_ins.global_position = $Spawner.global_position
		next_egg += rand_range(5, 20)
	pass
