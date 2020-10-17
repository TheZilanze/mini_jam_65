extends "res://scripts/actors/actor.gd"

var nav_mesh : Navigation2D = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _draw():
	
	
	
	pass


func _physics_process(delta):
	
	
	
	
	pass


# Steering behaviours
func seek(target_pos):
	return (target_pos - global_position).normalized() * speed
