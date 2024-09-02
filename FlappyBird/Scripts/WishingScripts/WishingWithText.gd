extends PanelContainer

onready var text := $MarginContainer/VBoxContainer/RichTextLabel
onready var anim_player := $AnimationPlayer


func _ready() -> void:
	anim_player.play("type_writting")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	get_tree().change_scene("res://Screens/MainUI.tscn")
