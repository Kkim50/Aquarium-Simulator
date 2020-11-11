extends Area2D

export var max_speed = 100
var mouse_over = false
var velocity
var given_name = "Whaleu"
var age = 0

func _ready():
	Global.screen_size = get_viewport_rect().size
	velocity = Vector2(20, 0)
	given_name = Global.fish_name
	show_accessories()
	$Heart.hide()
	$Heart.set_position(Vector2(0, -175))
	$Status.hide()
	$MoveTimer.start()
	$AgeTimer.start()
	$HappinessTimer.start()
	$FullnessTimer.start()
	connect("mouse_entered", self, "_mouse_over", [true])
	connect("mouse_exited",  self, "_mouse_over", [false])


func _process(delta):
	if position.x < 20 or position.x > Global.screen_size.x - 20:
		velocity.x = -velocity.x
	if position.y < 20 or position.y > Global.screen_size.y - 20:
		velocity.y = -velocity.y
	if velocity.x > 0:
		flip(true)
	elif velocity.x < 0:
		flip(false)
	position += velocity * delta
	position.x = clamp(position.x, 0, Global.screen_size.x)
	position.y = clamp(position.y, 0, Global.screen_size.y)

func flip(flag):
	$AnimatedSprite.flip_h = flag
	if flag:
		$CollisionShape2D.position.x = 15
		show_accessories()
	else:
		$CollisionShape2D.position.x = -15
		show_accessories()

func set_velocity(new_velocity):
	velocity = new_velocity

func start_moving():
	_on_MoveTimer_timeout()

func stop_moving():
	velocity = Vector2(0, 0)
	$MoveTimer.stop()

func start_eating():
	var flipped = $AnimatedSprite.flip_h
	$AnimatedSprite.animation = "eat"
	flip(flipped)
	stop_moving()

func stop_eating():
	$AnimatedSprite.animation = "swim"
	change_fullness(25)
	change_happiness(10)
	start_moving()

func _unhandled_input(event):
	if mouse_over and event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT and not event.is_pressed():
			change_happiness(10)
			$Heart.show()
			$EmoteTimer.start(1)
			get_tree().set_input_as_handled()

func change_happiness(amount):
	Global.happiness += amount
	Global.happiness = clamp(Global.happiness, Global.stat_min, Global.stat_max)

func change_fullness(amount):
	Global.fullness += amount
	Global.fullness = clamp(Global.fullness, Global.stat_min, Global.stat_max)

func _mouse_over(over):
    self.mouse_over = over

func _on_MoveTimer_timeout():
	velocity.x = randi() % max_speed
	velocity.y = randi() % max_speed
	if randf() > 0.5:
		velocity.x = -velocity.x
	if randf() > 0.5:
		velocity.y = -velocity.y
	$MoveTimer.start()

func _on_EmoteTimer_timeout():
	$Heart.hide()
	
func show_status():
	$Status.text = "Name: " + given_name + "\nAge: " + str(round(age)) + "\nHappiness: " + str(Global.happiness) + "\nFullness: " + str(Global.fullness)
	$Status.show()
	$StatusTimer.start(3)

func _on_StatusTimer_timeout():
	$Status.hide()

func _on_AgeTimer_timeout():
	age += 1
	$AgeTimer.start()

func _on_HappinessTimer_timeout():
	change_happiness(-1)
	$HappinessTimer.start()

func _on_FullnessTimer_timeout():
	change_fullness(-1)
	$FullnessTimer.start()

func show_accessories():
	$Hat.position.y = -78
	$Monocle.position.y = 32
	if $AnimatedSprite.flip_h:
		$Hat.position.x = 10
		$Monocle/Sprite.flip_h = true
		$Monocle.position.x = 16
	else:
		$Hat.position.x = -10
		$Monocle/Sprite.flip_h = false
		$Monocle.position.x = -16
	if Global.hat:
		$Hat.show()
	else:
		$Hat.hide()
	if Global.monocle:
		$Monocle.show()
	else:
		$Monocle.hide()
