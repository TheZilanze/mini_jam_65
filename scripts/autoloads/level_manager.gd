extends Node

const LEVEL_CONFIG_PATH = "res://data/levels.cfg"

var levels = []
var index = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	# Load level config
	var config = ConfigFile.new()
	var error = config.load(LEVEL_CONFIG_PATH)
	if error == OK:
		levels = config.get_value("levels", "levels", [])


func next_level():
	index += 1
	get_tree().change_scene(levels[index])
