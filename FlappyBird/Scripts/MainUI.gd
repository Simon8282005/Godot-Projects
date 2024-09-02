extends Control


onready var start_button := $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Play
onready var exit_button := $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Exit
onready var button_sound := $ButtonSound


func _on_Play_pressed() -> void:
	button_sound.play()
	yield(get_tree().create_timer(0.2), "timeout")
	
	get_tree().change_scene("res://Scenes/MainScene.tscn")


func _on_Exit_pressed() -> void:
	button_sound.play()
	yield(get_tree().create_timer(0.2), "timeout")
	
	get_tree().quit()
