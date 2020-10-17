extends State
class_name EnemyPatrolIdleState

var timer : Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)


func enter(params):
	owner.velocity = Vector2(0, 0)
	
	timer.start(params['idle_duration'])
	yield(timer, "timeout")
	emit_signal("finished", "patrol", {})


func exit():
	owner.velocity = owner.aim * owner.speed


func _physics_process(delta):
	# Check if state should be changed
	if owner.target_in_range() and owner.target_in_line_of_sight():
		owner.investigate_level += delta
		if owner.investigate_level >= owner.investigate_level_threshold:
			emit_signal("finished", "investigate", {})
	else:
		owner.investigate_level -= delta
		owner.investigate_level = clamp(owner.investigate_level, 0, owner.investigate_level_threshold)
	#print("investigate_level: " + str(owner.investigate_level))
