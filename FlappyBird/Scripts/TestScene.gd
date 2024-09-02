extends Node2D


signal game_over

onready var bird := $FlappyBird
onready var score_ui := $CanvasLayer/ScoreScreen
onready var base := $ParallaxBase
onready var background := $ParallaxBackground
onready var animation_player := $CountDown/AnimationPlayer
onready var pause_ui := $CanvasLayer/PauseUI
onready var game_over_ui := $CanvasLayer/GameOver
onready var speed_timer := $SpeedTimer

# Special gift for yonghui
onready var your_score := $"CanvasLayer/Your Score"

var pipe = null
var pipe_top_list = []
var pipe_down_list = []
var pipe_move_speed = 100
# var pipe_list = []

var score := 0
var START := false
var CAN_GAIN_SCORE := false
var GAME_OVER = false


func _ready() -> void:
	game_over_ui.visible = false
	pause_ui.visible = false
	
	# Special code here
	your_score.visible = false
	
	# Unpaused the game
	get_tree().paused = false
	
	pause_game()
	# Generate a pipe top and down
	randomize()

	connect("game_over", base, "stop_moving")
	connect("game_over", background, "stop_moving")
	connect("game_over", bird, "play_bump_on_wall_sound")
	# connect("game_over", game_over_ui, "game_over")
	
	# Play the count down animation and .... let the game start ！！！
	animation_player.play("count_down")
	
	# score += 1200
	# score_ui.update_score(String(score))


func _physics_process(delta: float) -> void:
	generate_multi_pipe()
		
	# Update the score
	if bird.detect_pipe() and CAN_GAIN_SCORE == false:
		score += 1
		CAN_GAIN_SCORE = true
		score_ui.update_score(String(score))
		bird.play_gain_score_sound()
	
	# Special code here
	# elif score >= 1220:
	#	yield(get_tree().create_timer(2), "timeout")
	#	your_score.visible = true
	#	get_tree().paused = true
	#	yield(get_tree().create_timer(2), "timeout")
	#	get_tree().change_scene("res://Scenes/Greeting Screens/WishingWithText.tscn")
	#	get_tree().paused = false
	
	if bird.detect_bump_on_pipe() and not pipe_top_list.empty() and not pipe_down_list.empty():
		game_over()
	
	if pipe_move_speed >= 2000:
		speed_timer.stop()
		
		
	CAN_GAIN_SCORE = bird.detect_pipe()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	start_game()


func pause_game() -> void:
	bird.set_physics_process(false)
	bird.get_node("Texture").playing = false
	background.set_process(false)
	base.set_process(false)


func start_game() -> void:
	background.set_process(true)
	base.set_process(true)
	
	bird.set_physics_process(true)
	bird.get_node("Texture").playing = true
	
	START = true
	
	generate_one_pair_pipe(rand_range(get_viewport_rect().size.x / 2, get_viewport_rect().size.x))
	
	speed_timer.start()


func game_over() -> void:
	if not GAME_OVER:
		bird.hit()
		bird.get_node("Texture").playing = false
		
		emit_signal("game_over")
		GAME_OVER = true
		
		game_over_ui.visible = true
		game_over_ui.play_game_over_sound()
		pause_game()


func generate_multi_pipe() -> void:
	if START:
		if not pipe_down_list.empty() and [pipe_down_list.size() - 1] != null:
			var x_2 = rand_range(300, get_viewport_rect().size.x + 200)
			
			if x_2 - pipe_down_list[pipe_down_list.size() - 1].position.x >= 60:
				generate_one_pair_pipe(x_2 + 80)


func generate_one_pair_pipe(x: int) -> void:
	var pipe_top := preload("res://Scenes/Pipe.tscn").instance()
	var pipe_down := preload("res://Scenes/Pipe.tscn").instance()
	# var pipe := preload("res://Scenes/Pipe.tscn").instance()
	
	var y_1 = rand_range(0, (get_viewport_rect().size.y / 2) - 200)
	var y_2 = rand_range((get_viewport_rect().size.y / 2) + 200, get_viewport_rect().size.y)
	# var coordinate_y := rand_range(300, get_viewport_rect().size.y + 50)
	
	var pipe_top_node := pipe_top.get_node(".")
	var pipe_down_node := pipe_down.get_node(".")
	
	if y_2 - y_1 >= 100 and not GAME_OVER:
		pipe_top.set_position(Vector2(x, y_1))
		pipe_down.set_position(Vector2(x, y_2))
	# pipe.set_position(Vector2(coordinate_x, coordinate_y))
		
		add_child(pipe_top)
		add_child(pipe_down)
		# add_child(pipe)
		pipe_top.set_move_speed(pipe_move_speed)
		pipe_down.set_move_speed(pipe_move_speed)
		
		# [Node that has the signal].connect("signal_name", [Node that handles the signal], "signal_handling_method_name")
		connect("game_over", pipe_top.get_node("."), "stop_moving")
		connect("game_over", pipe_down.get_node("."), "stop_moving")
		# connect("game_over", pipe.get_node("."), "stop_moving")
			
		pipe_top.set_rotate(true)
			
		pipe_top_list.append(pipe_top)
		pipe_down_list.append(pipe_down)
		# pipe_list.append(pipe)


func _on_Pause_pressed() -> void:
	pause_ui.visible = true
	pause_ui.play_pause_sound()
	get_tree().paused = true


func _on_SpeedTimer_timeout() -> void:
	pipe_move_speed += 10
