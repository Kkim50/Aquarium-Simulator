extends CanvasLayer

func _ready():
	pass

func _process(delta):
	if $FeedButton.is_hovered() or $PlayButton.is_hovered() or $CheckButton.is_hovered() or $DressButton.is_hovered():
		$HideTimer.start()

func show_menu():
	$FeedButton.show()
	$PlayButton.show()
	$CheckButton.show()
	$DressButton.show()

func hide_menu():
	$FeedButton.hide()
	$PlayButton.hide()
	$CheckButton.hide()
	$DressButton.hide()

func _on_HideTimer_timeout():
	hide_menu()
