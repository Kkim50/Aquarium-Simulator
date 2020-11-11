extends Node

func _ready():
	$GameFish.set_position($FishStartingPosition.position)
	$GameFish.can_move = false
	$QuitMenu.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $QuitMenu.visible:
			$QuitMenu.hide()
		else:
			$QuitMenu.show()

func _on_NameInput_text_entered(new_text):
	if new_text == "":
		Global.fish_name = "Whaleu"
	else:
		Global.fish_name = new_text
	$WelcomeLabel.text = "Welcome " + Global.fish_name + "!"
	$EnterNameLabel.hide()
	$NameInput.hide()
	$SceneChangeTimer.start()

func _on_SceneChangeTimer_timeout():
	get_tree().change_scene("res://Main.tscn")

func _on_YesButton_pressed():
	get_tree().quit()

func _on_NoButton_pressed():
	$QuitMenu.hide()
