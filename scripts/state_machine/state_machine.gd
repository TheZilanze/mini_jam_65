extends Node
class_name StateMachine

var states : Dictionary = {}
var current_state : State = null



# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("initialize")


func initialize():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.set_process(false)
			child.set_physics_process(false)
			child.connect("finished", self, "change_state")
			if not current_state:
				change_state(child.name, [])


func change_state(state_identifer, params):
	# Exit current state (if not null)
	if current_state:
		current_state.exit()
		current_state.set_process(false)
		current_state.set_physics_process(false)
	
	# Change to new state
	current_state = states[state_identifer]
	
	# Enter new state
	current_state.enter(params)
	current_state.set_process(true)
	current_state.set_physics_process(true)
