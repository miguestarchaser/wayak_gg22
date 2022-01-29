extends Node2D

var _mapa 			= load("res://escenas/mapa/mapa.tscn");
var	_player 		= load("res://escenas/player/player.tscn");
var _enemy 			= load("res://escenas/enemy/enemy.tscn");
var _counter 		= load("res://escenas/interface/contador.tscn");
var _timer 			= load("res://escenas/interface/timer.tscn");

var change_sound 	= preload("res://assets/sounds/coin.wav");
var pause_sound 	= preload("res://assets/sounds/pause.wav");
var enemies 		= [];
var current_enemy 	= 0;
var max_enemies 	= 0;
var ready 			= true;
var paused 			= false;
var mapa;
var player;	 
var enemy;
var counter;
var timer;


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
	counter = _counter.instance();
	add_child(counter);
	timer = _timer.instance();
	add_child(timer);
	timer.position.x = get_viewport_rect().size.x / 2;
	timer.position.y = timer.position.y +50;
	timer.start_timer();
	#print(get_viewport_rect().size.x);
	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_pressed("change") ):
		player.get_child(0)._change();
		mapa._change();
		$AudioStreamPlayer2D.stream = change_sound;
		$AudioStreamPlayer2D.play()
	if(Input.is_action_just_pressed("ui_accept") ):
		if(ready):
			if(paused):
				paused = false;
			else:
				paused = true;
			$AudioStreamPlayer2D.stream = pause_sound;
			$AudioStreamPlayer2D.play()
			player.get_child(0)._pause(paused);
			for _enemy in enemies:
				if(is_instance_valid(_enemy)):
					_enemy.get_child(0)._pause(paused);
		pass
	pass

func _spawn():
	if(max_enemies < 50 && !paused):
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
	counter._update_counter();
	max_enemies = max_enemies -1;
	enemies[id].queue_free();
	enemies.erase(id);
	pass
	
func _player_demage(demage):
	player.get_child(0)._demage(demage);
	pass
