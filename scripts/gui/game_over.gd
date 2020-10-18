extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	for player in get_tree().get_nodes_in_group("player"):
		player.connect("died", self, "on_player_died")


func on_player_died():
	show()


func _on_btn_try_again_pressed():
	get_tree().reload_current_scene()


func _on_btn_back_to_menu_pressed():
	get_tree().change_scene("res://scenes/gui/main_menu.tscn")
