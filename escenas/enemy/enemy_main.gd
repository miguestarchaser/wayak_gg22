extends KinematicBody2D


var velocity 			= Vector2();
var start 				= true
var speed 				= 50;
var raycast;
var direction 			= "d";
var cdir 				= 0;
var directions 			= ["d", "l", "u", "r","l","u","d","r"];
var _velocity 			= Vector2();

var hp 		= 3;
var type	= 0;
var status 	= 0;	

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	var random_value 	= rand_range(0,2);
	random_value		= int(floor(random_value));
	#print("spawn:"+str(random_value));
	if(random_value == 0):
		$ghost.show();
		$ghost.play();
		random_value 	= rand_range(0,2);
		random_value		= int(floor(random_value));
		if(random_value == 0):
			$ghost.animation = "luz";
			type = 0;
		else:
			$ghost.animation = "dark";
			type = 1;
	elif(random_value == 1):
		$skeleton.show();
		$skeleton.play();
		random_value 	= rand_range(0,2);
		random_value		= int(floor(random_value));
		if(random_value == 0):
			$skeleton.animation = "luz";
			type = 0;
		else:
			$skeleton.animation = "dark";
			type = 1;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if(start):
		_walk(delta);
	pass
	
func _atack(delta):
	pass

func _rotate(delta):
	#randomize();
	#var random_value 	= rand_range(0,7);
	#random_value		= int(floor(random_value));
	cdir 				= cdir +1;
	if(cdir > 7):
		cdir = 0;
	direction 			= directions[cdir];
	#print(direction);
	pass	

func _walk(delta):
	_velocity = Vector2();
	if(direction == "d"):
		_velocity.y = -speed 
	elif(direction == "u"):
		_velocity.y = speed 
	elif(direction == "l"):
		_velocity.x = -speed 
	elif(direction == "r"):
		_velocity.x = speed
	var collision = move_and_collide(_velocity*delta)
	if collision:
		if(collision.collider.name == "muros"):
			_rotate(delta);
		if(collision.collider.name == "enemy"):
			_rotate(delta);
	pass

func _fusion(delta):
	pass

func _demage(_type_bullet):
	if(_type_bullet == type):
		hp = hp -1;
		if(hp == 0):
			queue_free();
	pass	