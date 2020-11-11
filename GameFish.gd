extends Area2D

signal hit
export var speed = 400
var can_move

func _ready():
	Global.screen_size = get_viewport_rect().size
	can_move = false
	$AnimatedSprite.flip_h = true
	$CollisionShape2D.position.x = 15
	show_accessories()

func _process(delta):
	if can_move:
		var velocity = Vector2()
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		position += velocity * delta
		position.x = clamp(position.x, 0, Global.screen_size.x)
		position.y = clamp(position.y, 0, Global.screen_size.y)

func _on_GameFish_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func show_accessories():
	$Hat.position.y = -78
	$Monocle.position.y = 32
	if $AnimatedSprite.flip_h:
		$Hat.position.x = 10
		$Monocle/Sprite.flip_h = true
		$Monocle.position.x = 16
	else:
		$Hat.position.x = -16
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
