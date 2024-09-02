extends Control

onready var label := $VBoxContainer/HBoxContainer/Score
onready var pause_button := $VBoxContainer/HBoxContainer/HBoxContainer/VBoxContainer/Pause
onready var button_sound := $ButtonSound


func _ready() -> void:
	label.text = "0"


func update_score(new_score: String) -> void:
	label.text = new_score


func play_pause_sound() -> void:
	button_sound.play()
	yield(get_tree().create_timer(0.1), "timeout")
