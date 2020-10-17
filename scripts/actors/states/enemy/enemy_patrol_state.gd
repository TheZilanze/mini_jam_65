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
	if path.empty():
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


func find_path():
	if owner.nav_mesh:
		return owner.nav_mesh.get_simple_path(owner.global_position, patrol_points[patrol_index].global_position, true)
	else:
		return [patrol_points[patrol_index].global_position]
