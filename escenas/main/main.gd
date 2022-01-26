extends Node2D

var _mapa 	= load("res://escenas/mapa/mapa.tscn");
var	_player = load("res://escenas/player/player.tscn");

var mapa;
var player;	 

# Called when the node enters the scene tree for the first time.
func _ready():
	mapa = _mapa.instance();
	add_child(mapa);
	player = _player.instance();
	add_child(player);
	#player.position.x = mapa.get_child(0)/Position2D.transform.x;
	#player.position.y = mapa.get_child(0)/Position2D.transform.y;
	player.position = mapa._get_spawn();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
