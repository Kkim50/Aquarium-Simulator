extends Node

func _ready():
	var loaded =  Global.load_game()
	if loaded:
		$Label.text = "Data loaded\n\nHeading to your aquarium!"
		$MainTimer.start()
	else:
		$Label.text = "Data not found\n\nLet's get a fish!"
		$WelcomeTimer.start()

func _on_MainTimer_timeout():
	get_tree().change_scene("res://Main.tscn")

func _on_WelcomeTimer_timeout():
	get_tree().change_scene("res://Welcome.tscn")
