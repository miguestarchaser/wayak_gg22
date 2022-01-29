extends Node2D

var _mapa 			= load("res://escenas/mapa/mapa.tscn");
var	_player 		= load("res://escenas/player/player.tscn");
var _enemy 			= load("res://escenas/enemy/enemy.tscn");
var change_sound 	= preload("res://assets/sounds/coin.wav");
var enemies 		= [];
var current_enemy 	= 0;
var max_enemies 	= 0;

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
		$AudioStreamPlayer2D.stream = change_sound;
		$AudioStreamPlayer2D.play()
	pass

func _spawn():
	if(max_enemies < 50):
		#enemy = _enemy.instance();	
		enemies.push_back(_enemy.instance());
		add_child(enemies[current_enemy]);
		enemies[current_enemy].get_child(0).id 		= current_enemy;
		enemies[current_enemy].position = mapa._get_enemy_spawn();
		enemies[current_enemy].get_child(0).connect("_remove_enemy",self,"_remove_enemy");
		enemies[current_enemy].get_child(0).connect("_player_demage",self,"_player_demage");
		current_enemy 	= current_enemy +1 ;
		max_enemies		= max_enemies +1;
	pass
	
func _remove_enemy(id):
	max_enemies = max_enemies -1;
	enemies[id].queue_free();
	pass
	
func _player_demage(demage):
	player.get_child(0)._demage(demage);
	pass
