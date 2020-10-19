extends Control


func _ready():
	LEVEL_MANAGER.reset()


func _on_btn_play_pressed():
	get_tree().change_scene("res://scenes/gui/intro.tscn")


func _on_btn_how_to_play_pressed():
	get_tree().change_scene("res://scenes/gui/how_to_play.tscn")
