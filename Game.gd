extends Node
export (PackedScene) var Shark

var countdown
var starting_y_positions
var score
var done = true

func _ready():
	score = 0
	countdown = 3
	starting_y_positions = range(50, Global.screen_size.y, 50)
	$GameFish.set_position($FishStartingPosition.position)
	$GameFish.can_move = false
	$CountdownLabel.text = "Ready?"
	$HighScoreLabel.text = "High score: " + str(Global.high_score)
	$QuitMenu.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $QuitMenu.visible:
			$QuitMenu.hide()
		else:
			$QuitMenu.show()

func game_start():
	done = false
	$CountdownTimer.stop()
	$CountdownLabel.hide()
	$DodgeEnemiesLabel.hide()
	$GameFish.can_move = true
	$GameFish/CollisionShape2D.disabled = false
	$SpawnTimer.start()

func _on_StartButton_pressed():
	countdown = 3
	score = 0
	$DodgeEnemiesLabel.text = "Dodge the enemies!"
	$ScoreLabel.text = "Score: 0"
	$StartButton.hide()
	$CountdownLabel.text = str(countdown)
	$CountdownTimer.start()
	$GameFish.set_position($FishStartingPosition.position)
	$GameFish.can_move = false
	$GameFish.show()

func _on_CountdownTimer_timeout():
	countdown -= 1
	if countdown == 0:
		$CountdownLabel.text = "Go!"
		$CountdownTimer.start()
	elif countdown < 0:
		game_start()
	else:
		$CountdownLabel.text = str(countdown)
		$CountdownTimer.start()

func _on_BackButton_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_SpawnTimer_timeout():
	for i in range(randi() % 3 + 1):
		var shark = Shark.instance()
		shark.set_position(Vector2(Global.screen_size.x + 100, starting_y_positions[randi() % len(starting_y_positions)]))
		shark.connect("update_score", self, "increase_score")
		add_child(shark)
	$SpawnTimer.start()

func increase_score():
	if not done:
		score += 1
		$ScoreLabel.text = "Score: " + str(score)

func game_over():
	done = true
	$SpawnTimer.stop()
	$DodgeEnemiesLabel.text = "Game over!"
	$DodgeEnemiesLabel.show()
	$CountdownLabel.text = "Play again?"
	$CountdownLabel.show()
	$StartButton.show()
	Global.happiness += score
	Global.happiness = clamp(Global.happiness, Global.stat_min, Global.stat_max)
	Global.fullness -= score
	Global.fullness = clamp(Global.fullness, Global.stat_min, Global.stat_max)
	if score > Global.high_score:
		Global.high_score = score
		$HighScoreLabel.text = "High score: " + str(score)

func _on_GameFish_hit():
	game_over()

func _on_YesButton_pressed():
	Global.save_game()
	get_tree().quit()

func _on_NoButton_pressed():
	$QuitMenu.hide()
