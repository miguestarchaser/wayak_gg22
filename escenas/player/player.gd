extends KinematicBody2D

const MOTION_SPEED = 200 # Pixels/second.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#Movimiento
func _physics_process(_delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	move_and_slide(motion)
