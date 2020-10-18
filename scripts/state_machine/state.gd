extends Node
class_name State

signal finished(state_identifier, params)


func _ready():
	set_process(false)
	set_physics_process(false)


func enter(params):
	pass


func exit():
	pass
