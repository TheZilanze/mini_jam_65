extends "res://scripts/actors/actor.gd"

export(float) var visibility_range : float = 256
export(float, 0, 360) var fov : float = 140
export(float) var investigate_level_threshold : float = 0.5

var target
var nav_mesh : Navigation2D = null

var investigate_level : float = 0

var line_of_sight_offsets : PoolVector2Array = [
	Vector2(0, 0),
]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# TEMP.? Find a player as a target (use the first player found)
	for player in get_tree().get_nodes_in_group("player"):
		target = player
		break
	
	
	pass # Replace with function body.


func _draw():
	
	# Range
	draw_circle(Vector2.ZERO, visibility_range, Color(0, 0.5, 0.5, 0.5))
	
	# Line of sight
	if target:
		for offset in line_of_sight_offsets:
			draw_line(Vector2.ZERO, to_local(target.global_position + offset), Color.blue, 2.0)
	
	pass


func _physics_process(delta):
	
	
	
	
	pass


func target_in_range() -> bool:
	if target:
		return global_position.distance_squared_to(target.global_position) <= pow(visibility_range, 2)
	return false


func target_in_line_of_sight() -> bool:
	if target:
		# Check to see if the target is in the field of view (might still not be in line of sight)
		# If target isn't in field of view it can't be in line of sight and therefore we return false
		var to_target = target.global_position - global_position
		var angle = aim.angle_to(to_target)
		if abs(rad2deg(angle)) > fov * 0.5:
			return false
		
		# Use raycast to find if the target is in line of sight
		var space_state = get_world_2d().direct_space_state
		for offset in line_of_sight_offsets:
			var result = space_state.intersect_ray(global_position, target.global_position + offset, [self])
			if result and result['collider'].is_in_group("player"):
				return true
	return false


# Steering behaviours
func seek(target_pos):
	return (target_pos - global_position).normalized() * speed


