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
