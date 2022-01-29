extends KinematicBody2D

var _bullet 		= load("res://escenas/bullet/bullet.tscn");

var MOTION_SPEED 	= 200 # Pixels/second.
var HP 				= 10;
var DIR_VIEW 		= 0; 
var DIR_			= "d";
var type 			= 0;

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
	
func _process(delta):
	if(Input.is_action_pressed("ui_up")):
		DIR_ = "u"
	elif(Input.is_action_pressed("ui_down")):
		DIR_ = "d"
	elif(Input.is_action_pressed("ui_left")):
		DIR_ = "l"
	elif(Input.is_action_pressed("ui_right")):		
		DIR_ = "r"
	if(Input.is_action_just_pressed("space") ):
		_shoot();
	
	pass
	
	
func _shoot():
	var bpos = position;
	if(DIR_ == "d"):
		bpos.y = bpos.y - 20;
	elif(DIR_ == "u"):
		bpos.y = bpos.y + 20;
	elif(DIR_ == "l"):
		bpos.x = bpos.x - 20;
	elif(DIR_ == "r"):
		bpos.x = bpos.x + 20;
	var bullet = _bullet.instance();
	bullet.position = bpos
	get_parent().add_child(bullet)
	bullet.get_child(0)._set_dir(DIR_,type );
	
	#print(position);
	#add_child(bullet);
	pass

func _change():
	if(type  == 0):
		type  = 1;
		$Sprite.animation ="dark";
	else:
		type  = 0;
		$Sprite.animation ="luz";		
	pass
