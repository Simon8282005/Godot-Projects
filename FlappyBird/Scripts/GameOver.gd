extends Control


onready var sound_effect := $GameOverSound
onready var play_button := $MarginContainer/HBoxContainer/ButtonContainer/VBoxContainer/Play
onready var exit_button := $MarginContainer/HBoxContainer/ButtonContainer/VBoxContainer/Exit


func play_game_over_sound() -> void:
	sound_effect.stream = preload("res://Assets/Audios/game_over_sound.wav")
	sound_effect.play()


func _on_Play_pressed() -> void:
	sound_effect.stream = preload("res://Assets/Audios/button_click_sound.wav")
	sound_effect.play()
	print("Play")
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().change_scene("res://Scenes/MainScene.tscn")


func _on_Exit_pressed() -> void:
	sound_effect.stream = preload("res://Assets/Audios/button_click_sound.wav")
	sound_effect.play()
	print("Exit")
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://Screens/MainUI.tscn")
