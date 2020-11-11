extends Node

var index

# Called when the node enters the scene tree for the first time.
func _ready():
	index = 0
	$GameFish.set_position($FishStartingPosition.position)
	$GameFish.can_move = false
	$GameFish/AnimatedSprite.flip_h = false
	$GameFish.show_accessories()
	$Hat.set_position($ClothesPosition.position)
	$Hat.position.x += 3
	$Monocle.set_position($ClothesPosition.position)
	$Monocle.position.y += 30
	show_item()
	$QuitMenu.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $QuitMenu.visible:
			$QuitMenu.hide()
		else:
			$QuitMenu.show()

func _on_WearButton_pressed():
	if index == 0:
		Global.hat = true
	elif index == 1:
		Global.monocle = true
	$GameFish.show_accessories()
	$WearButton.disabled = true
	$UndoButton.disabled = false

func _on_UndoButton_pressed():
	if index == 0:
		Global.hat = false
	elif index == 1:
		Global.monocle = false
	$GameFish.show_accessories()
	$WearButton.disabled = false
	$UndoButton.disabled = true

func _on_BackButton_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_RightButton_pressed():
	index += 1
	if index > 1:
		index = 0
	show_item()
	$Dots.change_index(index)

func _on_LeftButton_pressed():
	index -= 1
	if index < 0:
		index = 1
	show_item()
	$Dots.change_index(index)
		
func show_item():
	if index == 0:
		$Hat.show()
		$Monocle.hide()
		if Global.hat:
			$WearButton.disabled = true
			$UndoButton.disabled = false
		else:
			$WearButton.disabled = false
			$UndoButton.disabled = true
	elif index == 1:
		$Hat.hide()
		$Monocle.show()
		if Global.monocle:
			$WearButton.disabled = true
			$UndoButton.disabled = false
		else:
			$WearButton.disabled = false
			$UndoButton.disabled = true

func _on_YesButton_pressed():
	Global.save_game()
	get_tree().quit()

func _on_NoButton_pressed():
	$QuitMenu.hide()
