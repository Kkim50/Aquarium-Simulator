extends Node

var screen_size
var fish_name
var high_score
var happiness
var fullness
var stat_min = 0
var stat_max = 100
var hat
var monocle

func _ready():
	high_score = 0
	happiness = 50
	fullness = 50
	hat = false
	monocle = false
	load_game()

func save_game():
	var save_dict = {
		"screen_size": screen_size,
		"fish_name": fish_name,
		"high_score": high_score,
		"happiness": happiness,
		"hat": hat,
		"monocle": monocle	
	}
	var file = File.new()
	file.open("user://savegame.save", File.WRITE)
	file.store_line(to_json(save_dict))
	file.close()

func load_game():
	var file = File.new()
	if not file.file_exists("user://savegame.save"):
		return false
	file.open("user://savegame.save", File.READ)
	var data = parse_json(file.get_line())
	screen_size = data["screen_size"]
	fish_name = data["fish_name"]
	high_score = data["high_score"]
	happiness = data["happiness"]
	hat = data["hat"]
	monocle = data["monocle"]
	file.close()
	return true
