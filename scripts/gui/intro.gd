extends Control


func _on_btn_continue_pressed():
	# TODO: Load the first level...
	#get_tree().change_scene("res://scenes/gui/main_menu.tscn")
	LEVEL_MANAGER.next_level()
