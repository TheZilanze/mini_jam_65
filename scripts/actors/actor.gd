extends KinematicBody2D

export(float) var speed : float = 128

var velocity : Vector2 = Vector2(speed, speed)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()


func _draw():
	# Draw background?
	#...
	
	# Draw outline
	draw_arc(Vector2.ZERO, 32, 0, 2 * PI, 32, Color.green, 2.0)
	
	# Draw look direction
	draw_line(Vector2.ZERO, Vector2(32, 0), Color.green, 2.0)


func _physics_process(delta):
	# Update look direction
	look_at(global_position + velocity)
	
	# Clamp velocity
	velocity = velocity.clamped(speed)
	
	# Move
	velocity = move_and_slide(velocity)
