extends Node2D

var time 	= 99;
var ready 	= false;
var texture;

signal _game_over();

# Called when the node enters the scene tree for the first time.
func _ready():
	$timer.set_wait_time(1);
	$timer.start();
	$timer.paused = true;
	$timer.connect("timeout", self, "update_timer");
	pass # Replace with function body.
	
func start_timer():
	$timer.paused = false;
	pass
	
func stop_timer():
	$timer.paused = true;
	pass

func update_timer():
	time 	= time -1;
	var tmp = str(time);
	if(tmp.length() > 1):
		texture = load("res://assets/Numbers/number"+tmp[0]+".png");
		$Numero1.set_texture(texture);
		#$Numero1.scale = Vector2(0.5, 0.5)
		texture = load("res://assets/Numbers/number"+tmp[1]+".png");
		$Numero2.set_texture(texture);
		#$Numero2.scale = Vector2(0.5, 0.5)
	else:
		texture = load("res://assets/Numbers/number0.png");
		$Numero1.set_texture(texture);
		texture = load("res://assets/Numbers/number"+tmp[0]+".png");
		$Numero2.set_texture(texture);
		#$Numero2.scale = Vector2(0.5, 0.5);
	if(time <= 0):
		$timer.paused = true;
		emit_signal("_game_over");
	pass
