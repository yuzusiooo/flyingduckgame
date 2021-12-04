extends Node2D

export var spawns = []
var allow_spawn = true
var crab = preload("res://actors/Crab/Crab.tscn")
var i = 0

func _ready():
	pass
func _physics_process(delta):
	if (allow_spawn and i < spawns.size()):
		var c_ins = crab.instance()
		get_node(spawns[i]).add_child(c_ins)
		allow_spawn = false
		$IntervalTimer.start(0.5)
		i += 1
func _on_Despawn_timeout():
	queue_free()
func _on_IntervalTimer_timeout():
	allow_spawn = true
