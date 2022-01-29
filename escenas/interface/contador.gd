extends Node2D
var texture;
var points = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _set_defaults():
	#texture = load("res://assets/"+avatar);
	#$sprite.set_texture(texture);
	#position.x = _position.origin.x
	#position.y = _position.origin.y
	#$sprite.scale = Vector2(0.5, 0.5)
	$Numero1.scale = Vector2(0.5, 0.5)
	$Numero2.scale = Vector2(0.5, 0.5);
	pass

func _update_counter():
	update_points();
	pass

func update_points():
	points = points +1;
	var tmp = str(points);
	if(tmp.length() > 1):
		texture = load("res://assets/Numbers/number"+tmp[0]+".png");
		$Numero1.set_texture(texture);
		$Numero1.scale = Vector2(0.5, 0.5)
		texture = load("res://assets/Numbers/number"+tmp[1]+".png");
		$Numero2.set_texture(texture);
		$Numero2.scale = Vector2(0.5, 0.5)
	else:
		texture = load("res://assets/Numbers/number"+tmp[0]+".png");
		$Numero2.set_texture(texture);
		$Numero2.scale = Vector2(0.5, 0.5);
	pass
	
