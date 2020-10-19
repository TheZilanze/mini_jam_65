extends KinematicBody2D

signal died

export(float) var speed : float = 256

onready var animated_sprite = $animated_sprite

var velocity : Vector2 = Vector2(0, 0) setget set_velocity
var aim : Vector2 = Vector2(0, 0) setget set_aim

var is_alive = true


func set_velocity(value):
	velocity = value.clamped(speed)


func set_aim(value):
	aim = value.normalized()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#update()
	pass


func _draw():
	# Draw background?
	#...
	
	"""
	# Draw outline
	draw_arc(Vector2.ZERO, 32, 0, 2 * PI, 32, Color.green, 2.0)
	
	# Draw look direction
	draw_line(Vector2.ZERO, Vector2(32, 0), Color.green, 2.0)
	"""


func _physics_process(delta):
	# If dead do nothing
	if not is_alive:
		return
	
	# Update look direction
	look_at(global_position + aim)
	
	# Animation
	if velocity.length_squared() > 0.001:
		animated_sprite.play("walk")
	elif animated_sprite.animation == "walk":
		animated_sprite.play("idle")
	
	# Clamp velocity
	velocity = velocity.clamped(speed)
	
	# Move
	velocity = move_and_slide(velocity)


func kill():
	is_alive = false
	emit_signal("died")
