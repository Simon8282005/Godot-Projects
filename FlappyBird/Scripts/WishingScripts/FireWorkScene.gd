extends Node2D


onready var firework_1 := preload("res://Scenes/Greeting Screens/Firework/Firework_red.tscn").instance()
onready var firework_2 := preload("res://Scenes/Greeting Screens/Firework/Firework_blue.tscn").instance()

var CAN_EMIT = true

var screen_width := get_viewport_rect().size.x
var screen_height := get_viewport_rect().size.y


func _ready() -> void:
	add_child(firework_1)
	add_child(firework_2)
	
	for i in range(10):
		go_fire()


func _process(delta: float) -> void:	
	pass


func go_fire() -> void:
	randomize()
	
	yield(get_tree().create_timer(2), "timeout")
	
	var random_x = rand_range(0, screen_width)
	var random_x_2 = rand_range(0, screen_width)
	var random_y = rand_range(0, screen_height)
	var random_y_2 = rand_range(0, screen_height)
	
	firework_1.global_position = Vector2(random_x, random_y)
	firework_2.global_position = Vector2(random_x_2, random_y_2)
	# firework_1.global_position = Vector2(100, 300)
