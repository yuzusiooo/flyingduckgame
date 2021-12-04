extends Node2D

var score = 0
var eggs = 0
var bread = 0
var score_string = "Your final score is "
var egg_string = "You collected "
var bread_string = "and ate "

func _ready():
	$Duck.stagepar = self
	$Progression.stagepar = self
	$FinalText/tldrLabel.text = ""
	$FinalText/DetailsLabel.text = ""

func _process(delta):
	$ScoreTXT.text = String(score)

func add_score(gain):
	score += gain

func duck_defeated():
	$FinalText/tldrLabel.text = "Oh no!"
	score_string += String(score) + "\n"
	make_string()
	$FinalText/DetailsLabel.text = "You are defeated!\n" + score_string + egg_string + bread_string

func game_won():
	$FinalText/tldrLabel.text = "You won!"
	make_string()
	$FinalText/DetailsLabel.text = "You made it through!\n" + score_string + egg_string + bread_string

func make_string():
	egg_string += String(eggs) + " eggs\n"
	bread_string += String(bread) + " breadcrumbs. \n"
