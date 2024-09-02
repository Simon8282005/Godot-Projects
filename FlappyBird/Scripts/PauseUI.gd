extends Control


onready var start_button :=  $MarginContainer/HBoxContainer/ButtonContainer/Start
onready var exit_button :=  $MarginContainer/HBoxContainer/ButtonContainer/Exit
onready var button_sound := $ButtonSound


func _on_Exit_pressed() -> void:
	button_sound.play()
	yield(get_tree().create_timer(0.2), "timeout")
	
	get_tree().change_scene("res://Screens/MainUI.tscn")


func _on_Start_pressed() -> void:
	button_sound.play()
	yield(get_tree().create_timer(0.2), "timeout")
	
	visible = false
	get_tree().paused = false

func play_pause_sound() -> void:
	button_sound.play()
	yield(get_tree().create_timer(0.1), "timeout")
