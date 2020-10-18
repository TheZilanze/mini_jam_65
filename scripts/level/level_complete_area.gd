extends Area2D

signal level_completed


func _on_level_complete_area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("level_completed")
		#yield?...
		LEVEL_MANAGER.next_level()
