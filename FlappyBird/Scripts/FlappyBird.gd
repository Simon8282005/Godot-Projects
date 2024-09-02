extends KinematicBody2D

export var INIT_POSITION := Vector2(100, 0)
export var gravity := 250
export var fly_height := 100

# onready var sprite := $Texture
onready var bird_texture := $Texture
onready var tween := $Tween
onready var ray := $PipeDetection
onready var audio_player := $AudioStreamPlayer2D

var velocity := Vector2.ZERO
var die = false
var bump_on_wall = false

var audio_list = [
	preload("res://Assets/Audios/die.wav"), 
	preload("res://Assets/Audios/hit.wav"), 
	preload("res://Assets/Audios/point.wav"), 
	preload("res://Assets/Audios/swoosh.wav"), 
	preload("res://Assets/Audios/wing.wav")
]


func fly() -> void:
	velocity.y = -fly_height


func hit() -> void:
	die = true


func _ready() -> void:
	randomize()
	_random_animation()
	position = INIT_POSITION
	
	ray.enabled = true	


func _physics_process(delta: float) -> void:
	# If up key is press, bird fly up
	# need to calculate face direction
	if die == false:
		if Input.is_action_just_pressed("ui_up"):
			fly()
			check_and_rotate(velocity)
	
	velocity.y += gravity * delta
	check_and_rotate(velocity)
	move_and_slide(velocity, Vector2.UP)


func _random_animation() -> void:
	var animations = bird_texture.frames.get_animation_names()
	bird_texture.animation = animations[randi() % 3]
	bird_texture.play(bird_texture.animation)


func play_bump_on_wall_sound() -> void:
	if not bump_on_wall:
		audio_player.stream = audio_list[1]
		
		if not audio_player.playing:
			audio_player.play()


func play_gain_score_sound() -> void:
	audio_player.stream = audio_list[2]
	
	if not audio_player.playing:
		audio_player.play()


func detect_bump_on_pipe() -> bool:
	var collided = false
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.has_method("stop_moving") or typeof(collision.collider) == 17:
			collided = true
			play_bump_on_wall_sound()
			bump_on_wall = true
		else:
			collided = false
			
	return collided


func detect_pipe() -> bool:
	if ray.is_colliding() and ray.get_collider().is_in_group("pipe"):
		return ray.get_collider().is_in_group("pipe")
	else:
		return ray.get_collider().is_in_group("pipe")


# Degree must be in radian
func check_and_rotate(velocity: Vector2) -> void:
	# If velocity.y += gravity * delta
	if sign(velocity.y) == 1:
		# 120 degree
		tween.interpolate_property(bird_texture, "rotation", 0, 15, 1)
		tween.start()
	elif sign(velocity.y) == -1:
		# 45 degree
		tween.interpolate_property(bird_texture, "rotation", 0, -15, 1)
		tween.start()
