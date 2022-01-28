extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _get_spawn():
	return $Position2D.transform.origin;	
	pass;
	
func _get_enemy_spawn():
	var pos 			= Vector2();
	randomize();
	var random_value 	= rand_range(0,4);
	random_value		= int(floor(random_value));
	if(random_value == 0):
		pos = $spawn1.transform.origin;
	elif(random_value == 1):
		pos = $spawn2.transform.origin;
	elif(random_value == 2):
		pos = $spawn3.transform.origin;
	elif(random_value == 3):
		pos = $spawn4.transform.origin;
	return pos;
	pass
