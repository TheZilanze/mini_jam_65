extends State
class_name EnemyInvestigateState

#...


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func enter(params):
	owner.target_last_known_position = owner.target.global_position
	
	owner.investigate_icon.show()


func exit():
	owner.target_last_known_position = null
	
	owner.investigate_icon.hide()


func _physics_process(delta):
	# Move towards the target if in line of sight
	# Else move towards the last known position, if that is reached without 
	# getting line of sight of the target again go back to patrolling
	if owner.target_in_line_of_sight():
		owner.velocity += owner.seek(owner.target.global_position)
		owner.target_last_known_position = owner.target.global_position
		owner.investigate_level += delta
		if owner.investigate_level >= owner.attack_level_threshold:
			emit_signal("finished", "attack", {})
	# TODO: This should be another state where the player looks around.
	# 		If the investigate level goes below zero it starts patrolling again.
	# 		If the investigate level goes above the investigate threshold then start investigating again
	elif owner.target_last_known_position == null:
		# TODO: Look around...
		owner.investigate_level -= delta
		if owner.investigate_level <= 0:
			owner.investigate_level = 0
			emit_signal("finished", "patrol", {})
	else:
		owner.velocity += owner.seek(owner.target_last_known_position)
		# If we have reached the last known position of the target (and the target isn't in line of sight) then we go back to patrolling
		if owner.global_position.distance_to(owner.target_last_known_position) < owner.speed * delta:
			# TODO: Change to state for looking around before going back to patrolling...
			#emit_signal("finished", "patrol", {})
			owner.target_last_known_position = null
	
	# Update aim
	owner.aim = owner.velocity
