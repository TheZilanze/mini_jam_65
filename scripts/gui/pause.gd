extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


func _notification(what):
	if what == NOTIFICATION_WM_FOCUS_OUT:
		get_tree().paused = true
		show()


func _on_btn_resume_pressed():
	get_tree().paused = false
	hide()
