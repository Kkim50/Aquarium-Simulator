extends Node
export (PackedScene) var Food

func _ready():
	randomize()
	$Fish.set_position($FishStartingPosition.position)
	$Menu.hide_menu()
	$QuitMenu.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $QuitMenu.visible:
			$QuitMenu.hide()
		else:
			$QuitMenu.show()

func _on_Background_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT and not event.is_pressed():
			$Menu.set_offset(event.position)
			$Menu.show_menu()
			$Menu/HideTimer.start()

func _on_CheckButton_pressed():
	$Fish.show_status()
	$Menu.hide_menu()

func _on_FeedButton_pressed():
	if not $FeedTimer.is_stopped():
		$Fish.stop_eating()
	var num_flakes = randi() % 3 + 4
	for i in num_flakes:
		var food = Food.instance()
		var pos = $Fish.position
		if $Fish/AnimatedSprite.flip_h:
			pos.x = pos.x + 60 + randi() % 50 - 25
		else:
			pos.x = pos.x - 60 + randi() % 50 - 25
		pos.y = pos.y - 50 + randi() % 50 - 25
		food.position = pos
		food.z_index = 1
		add_child(food)
		food.set_remove_height($Fish.position.y + 10)
	$Fish.start_eating()
	$Menu.hide_menu()
	$FeedTimer.start()

func _on_FeedTimer_timeout():
	$Fish.stop_eating()
	$FeedTimer.stop()

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Game.tscn")

func _on_DressButton_pressed():
	get_tree().change_scene("res://Dress.tscn")

func _on_YesButton_pressed():
	Global.save_game()
	get_tree().quit()

func _on_NoButton_pressed():
	$QuitMenu.hide()
