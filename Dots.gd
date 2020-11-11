extends Node2D
export (PackedScene) var Dot
export var num_dots = 2
var dots = []
var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize(num_dots)

func initialize(n_dots):
	dots = []
	num_dots = n_dots
	selected = 0
	for i in range(n_dots):
		var dot = Dot.instance()
		dot.position.x = i * 30
		add_child(dot)
		dots.append(dot)
	dots[0].get_child(0).animation = "dot_full"

func change_index(i):
	dots[selected].get_child(0).animation = "dot_empty"
	dots[i].get_child(0).animation = "dot_full"
	selected = i