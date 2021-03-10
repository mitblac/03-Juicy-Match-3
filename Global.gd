extends Node

var score = 0
var time = 600
var visibility = 1

var multiplier = 2

var level = 1

var level1_default = 60

var Bonus = null

signal score_changed
signal time_changed
signal time_visible
signal bonus_changed

var scores = {
	0:0,
	1:0,
	2:0,
	3:10,
	4:20,
	5:50,
	6:100,
	7:200,
	8:300,
	9:1000
}

func _ready():
	if level == 1:
		score = 0
		time = 800
		emit_signal("time_visible")

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func change_score(s):
	var camera = get_node_or_null("/root/Game/Camera")
	if camera:
		camera.add_trauma(0.5)
	score += s
	emit_signal("score_changed")
	if level == 1 and score >= 1000:
		score = 0
		var _new_scene = get_tree().change_scene("res://Game2.tscn")
		level = 2
	if level == 2 and score >= 1500:
		time = 600
		score = 0
		visibility = 2
		var _new_scene = get_tree().change_scene("res://Game3.tscn")
		level = 3
	if level == 3 and score >= 2000:
		if time >= 0:
			time = 600
			score = 0
			visibility = 1
			var _new_scene = get_tree().change_scene("res://UI/End_Game.tscn")
			level = 1
		else:
			time = 600
			score = 0
			visibility = 1
			var _new_scene = get_tree().change_scene("res://UI/End_Game_Late.tscn")
			level = 1
	emit_signal("time_visible")
	
func change_time():
	time -= 1
	emit_signal("time_changed")
	
	
func change_bonus(b):
	Bonus = b
	emit_signal("bonus_changed")
