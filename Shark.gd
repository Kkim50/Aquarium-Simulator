extends RigidBody2D

signal update_score
export var speed = 400

func _ready():
	$AnimatedSprite.frame = randi() % 4

func _process(delta):
	position.x -= speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("update_score")
	queue_free()
