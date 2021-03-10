extends Control

func _ready():
	var _score_changed = Global.connect("score_changed",self,"_on_score_changed")
	var _time_changed = Global.connect("time_changed",self,"_on_time_changed")
	var _time_visible = Global.connect("time_visible",self,"_on_time_visible")
	var _bonus_changed = Global.connect("bonus_changed",self,"_on_bonus_changed")
	_on_score_changed()
	_on_time_changed()
	_on_time_visible()
	_on_bonus_changed()
	$Instructions.show()
	get_tree().paused = true

func _on_score_changed():
	$Score.text = "Energy: " + str(Global.score)
	
func _on_time_changed():
	$Time.text = "Time: " + str(Global.time)
	
func _on_bonus_changed():
	if Global.level == 2 or Global.level == 3:
		var ch = $Bonus.get_children()
		for c in ch:
			if c.name == "Bonus":
				c.queue_free()
	if Global.Bonus != null:
		var bonus = Global.Bonus.instance()
		bonus.position = Vector2(215,78)
		bonus.name = "Bonus"
		$Bonus.add_child(bonus)

func _on_time_visible():
	if Global.visibility == 1:
		$Time.hide()
	elif Global.visibility == 2:
		$Time.show()


func _on_Timer_timeout():
	Global.change_time()


