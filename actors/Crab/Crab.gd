extends Node2D

export var hp = 3
var stagepar

func _ready():
	$Behaviour.set_new(self)

func _process(delta):
	$Behaviour._update(delta)
	check_dead()
	pass

func check_dead():
	if (hp <= 0):
		var breadcrumbs = rand_range(1, 4)
		var bread = preload("res://actors/Bread.tscn")
		for n in breadcrumbs:
			var b_inst = bread.instance()
			get_tree().get_current_scene().add_child(b_inst)
			b_inst.set_new(true, global_position)
		queue_free()

func _on_Hitbox_area_entered(area):
	if (area.name == "Pellet_Hitbox"):
		area.get_parent().queue_free()
		hp -= 1
	pass

func _on_Despawn_timeout():
	queue_free()
