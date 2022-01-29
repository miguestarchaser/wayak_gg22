extends Node2D

var _mapa 	= load("res://escenas/mapa/mapa.tscn");
var	_player = load("res://escenas/player/player.tscn");
var _enemy 	= load("res://escenas/enemy/enemy.tscn");

var mapa;
var player;	 
var enemy;

func _ready():
	$spawner.set_wait_time(1);
	$spawner.start();
	$spawner.paused = false;
	$spawner.connect("timeout", self, "_spawn")
	mapa = _mapa.instance();
	add_child(mapa);
	player = _player.instance();
	add_child(player);
	player.position = mapa._get_spawn();

	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_pressed("change") ):
		player.get_child(0)._change();
		mapa._change();
	pass

func _spawn():
	enemy = _enemy.instance();
	add_child(enemy);
	enemy.position = mapa._get_enemy_spawn();
	pass
