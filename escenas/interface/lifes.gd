extends Node2D

var lifes = 5;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _demage():
	lifes = lifes -1;
	if(lifes >= 0):
		if(lifes == 4):
			$l5.hide();
		elif(lifes == 3):
			$l4.hide();
		elif(lifes == 2):
			$l3.hide();
		elif(lifes == 1):
			$l2.hide();
		elif(lifes == 0):
			$l1.hide();
	pass

func _restore():
	lifes = 5;
	$l5.show();
	$l4.show();
	$l3.show();
	$l2.show();
	$l1.show();
	pass
