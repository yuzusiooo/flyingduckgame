extends Node2D

export var speed = 800
var p

func _ready():
	pass
func _process(delta):
	position += Vector2.RIGHT * speed * delta
	pass

func set_new(parent):
	p = parent
	self.global_position = p.global_position


func _on_Pellet_Hitbox_area_entered(area):
	if (p != null):
		if (area.name == "Crab_Hitbox"):
			p.add_score(10)
