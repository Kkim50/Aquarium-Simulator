extends RigidBody2D

var types = ["green", "orange", "yellow"]
var remove_height

func _ready():
	$AnimatedSprite.animation = types[randi() % types.size()]
	remove_height = get_viewport_rect().size.y

func _process(delta):
	if position.y > remove_height:
		queue_free()

func set_remove_height(height):
	remove_height = height
