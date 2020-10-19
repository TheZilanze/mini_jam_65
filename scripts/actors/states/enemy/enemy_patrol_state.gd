extends State
class_name EnemyPatrolState

var patrol_points : Array = []
var patrol_index = 1
var path : PoolVector2Array = []





func _ready():
	# Find all patrol points
	for child in get_children():
		if child is Position2D:
			patrol_points.append(child)
	# Move to first position in patrol
	owner.global_position = patrol_points[0].global_position
	# Find initial path
	path = find_path()


func enter(params):
	path = find_path()


func exit():
	path = []


func _physics_process(delta):
	# TODO: Handle that the path from the nav mesh is in local coordinates?
	
	# Update velocity
	owner.velocity += owner.seek(path[0])
	
	# Update aim
	owner.aim = owner.velocity
	
	# If the next position of the path has been reached remove it
	# If that was the last position in the path, find a path to the next patrol point
	if owner.global_position.distance_to(path[0]) < owner.speed * delta:
		path.remove(0)
		if path.empty():
			patrol_index = (patrol_index + 1) % patrol_points.size()
			path = find_path()
			if patrol_points[(patrol_index - 1) % patrol_points.size()].stop:
				emit_signal("finished", "patrol_idle", {idle_duration = 1.0})
	
	
	# Check if state should be changed
	if owner.target_in_range() and owner.target_in_line_of_sight():
		owner.investigate_level += delta
		if owner.target.is_alive and owner.investigate_level >= owner.investigate_level_threshold:
			emit_signal("finished", "investigate", {})
	else:
		owner.investigate_level -= delta
		owner.investigate_level = clamp(owner.investigate_level, 0, owner.investigate_level_threshold)


func find_path():
	var new_path = []
	if owner.nav_mesh:
		new_path = owner.nav_mesh.get_simple_path(owner.global_position, patrol_points[patrol_index].global_position, true)
	if new_path.empty():
		new_path = [patrol_points[patrol_index].global_position]
	return new_path
