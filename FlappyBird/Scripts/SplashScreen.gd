extends Control

onready var anim_player := $AnimationPlayer
onready var image := $TextureRect


func _ready() -> void:
	anim_player.play("fade")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	get_tree().change_scene("res://Screens/MainUI.tscn")


func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		anim_player.seek(INF)
		get_tree().change_scene("res://Screens/MainUI.tscn")
