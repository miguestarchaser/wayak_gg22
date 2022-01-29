extends KinematicBody2D


var velocity 			= Vector2();
var start 				= true
var speed 				= 50;
var raycast;
var direction 			= "d";
var cdir 				= 0;
var directions 			= ["d", "l", "u", "r","l","u","d","r"];
var _velocity 			= Vector2();

var demage_sound 		= preload("res://assets/sounds/enemy_demage.wav");
var fusion_sound 		= preload("res://assets/sounds/fusion.wav");
var dead_sound 			= preload("res://assets/sounds/destruye.wav");

var hp 			= 3;
export var type	= 0;
var status 		= 0;	
export var spt 	= 0;
export var lv 	= 0;
export var id	= 0;
export var demage= 1;
var _size 	= Vector2();
var _scale 	= Vector2();	

signal _remove_enemy(id);
signal _player_demage(demage);

# Called when the node enters the scene tree for the first time.
func _ready():
	$scale.set_wait_time(0.1);
	$scale.start();
	$scale.paused = true;
	$scale.connect("timeout", self, "_resize")
	
	$dead.set_wait_time(0.3);
	$dead.start();
	$dead.paused = true;
	$dead.connect("timeout", self, "_remove")
	randomize();
	var random_value 	= rand_range(0,2);
	random_value		= int(floor(random_value));
	#print("spawn:"+str(random_value));
	if(random_value == 0):
		spt = 0;
		$ghost.show();
		$ghost.play();
		random_value 	= rand_range(0,2);
		random_value		= int(floor(random_value));
		_scale = $ghost.scale;
		if(random_value == 0):
			$ghost.animation = "luz";
			type = 0;
		else:
			$ghost.animation = "dark";
			type = 1;
	elif(random_value == 1):
		spt = 1;
		$skeleton.show();
		$skeleton.play();
		_scale = $skeleton.scale;
		random_value 	= rand_range(0,2);
		random_value		= int(floor(random_value));
		if(random_value == 0):
			$skeleton.animation = "luz";
			type = 0;
		else:
			$skeleton.animation = "dark";
			type = 1;
		
		random_value 	= rand_range(2,5);
		random_value		= int(floor(random_value));
		hp = random_value;
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
		if(collision.collider.name == "player"):
			emit_signal("_player_demage",demage);
		if(collision.collider.name == "enemy"):
			if(collision.collider.spt == spt && type == collision.collider.type):
				if(hp > collision.collider.hp):
					_giga();
					collision.collider._remove();
				else:
					collision.collider._giga();
					_remove();
			else:
				_rotate(delta);
	pass

func _fusion(delta):
	pass

func _demage(_type_bullet):
	if(_type_bullet == type):
		hp = hp -1;
		if(hp == 0):
			#if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stream = dead_sound;
			$AudioStreamPlayer2D.play()
			#queue_free();
			$dead.paused = false;
		else:
			#if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stream = demage_sound;
			$AudioStreamPlayer2D.play()
			var s = Vector2();
			if(spt == 0):
				s.x = $ghost.scale.x + 0.070 ;
				s.y = $ghost.scale.y + 0.070 ;
				$ghost.scale = s;
			else:
				s.x = $skeleton.scale.x + 0.070 ;
				s.y = $skeleton.scale.y + 0.070 ;
				$skeleton.scale = s;
			$scale.start();
			$scale.paused = false;
	pass	

func _resize():
	var s = Vector2();
	s.x = _scale.x ;
	s.y = _scale.y ;
	if(spt == 0):
		$ghost.scale = s;
	else:
		$skeleton.scale = s;
	$scale.paused = true;
	pass

func _giga():
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = fusion_sound;
		$AudioStreamPlayer2D.play()
	var s = Vector2();
	if(spt == 0):
		s.x = $ghost.scale.x + 0.3 ;
		s.y = $ghost.scale.y + 0.3 ;
		$ghost.scale = s;
		_scale = $ghost.scale;
	else:
		s.x = $skeleton.scale.x + 0.3 ;
		s.y = $skeleton.scale.y + 0.3 ;
		$skeleton.scale = s;
		_scale = $skeleton.scale;
	hp 		= hp + 3;
	speed 	= speed - 5;
	demage 	= demage + 1;
	pass
	
	
func _remove():
	$dead.paused = true;
	#queue_free();
	emit_signal("_remove_enemy",id);
	pass
