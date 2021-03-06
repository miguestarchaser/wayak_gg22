extends KinematicBody2D

var _velocity 	= Vector2();
var _dir 		= "";
var _type 		= 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _set_dir(dir,type):
	_dir = dir;
	_type = type;
	if(type == 0):
		 $ColorRect.color = Color(1, 1, 1 , 1);
	else:
		$ColorRect.color = Color(0, 0, 0, 1);
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(_dir == "d"):
		_velocity.y = -10 
	elif(_dir == "u"):
		_velocity.y = 10 
	elif(_dir == "l"):
		_velocity.x = -10 
	elif(_dir == "r"):
		_velocity.x = 10
	var col = move_and_collide(_velocity)
	if(col != null):
		if(col.collider.name == "enemy"):
			col.collider._demage(_type);
		if(col.collider.name != "player"):
			queue_free();
		
	pass
