extends State
class_name EnemyInvestigateState

#...


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func enter(params):
	print("[enemy_investigate_state.gd] enter...")
	
	
	pass


func exit():
	pass
	



func _physics_process(delta):
	# TEMP.
	owner.velocity = owner.seek(owner.target.global_position)
	owner.aim = owner.velocity
