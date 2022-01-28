extends "res://escenas/enemy/enemy_main.gd"



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	var random_value 	= rand_range(0,2);
	random_value		= int(floor(random_value));
	#print("spawn:"+str(random_value));
	if(random_value == 0):
		$ghost.show();
		$ghost.play();
	elif(random_value == 1):
		$skeleton.show();
		$skeleton.play();
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

