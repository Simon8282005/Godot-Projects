extends Node2D

onready var firework_1 := $Particles2D
onready var firework_2 := $Particles2D2
onready var firework_3 := $Particles2D3

var firework_list = []

func _ready() -> void:
	firework_list.append(firework_1)
	firework_list.append(firework_2)
	firework_list.append(firework_3)

func _process(delta: float) -> void:
	pass
		
	
	
