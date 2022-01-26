extends KinematicBody2D

var MOTION_SPEED 	= 200 # Pixels/second.
var HP 				= 10;
var DIR_VIEW 		= 0; 			 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#Movimiento
func _physics_process(_delta):
	if(Input.is_action_pressed("ui_up") && DIR_VIEW==0):
		$Sprite.set_frame(1);
		DIR_VIEW = 1;
	elif(Input.is_action_pressed("ui_down") && DIR_VIEW==1):
		$Sprite.set_frame(0);
		DIR_VIEW = 0;
		pass
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	
	move_and_slide(motion)
