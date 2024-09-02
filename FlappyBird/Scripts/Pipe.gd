extends StaticBody2D

export var move_speed := 100 setget set_move_speed, get_move_speed

onready var sprite := $Sprite

var CAN_MOVE = true


func _physics_process(delta: float) -> void:
	if CAN_MOVE:
		move(delta)
	
	if sign(position.x + 20) == -1:
		free()


func set_move_speed(new_value: int) -> void:
	move_speed = new_value


func get_move_speed() -> int:
	return move_speed


func set_postion(new_position: Vector2) -> void:
	global_position = new_position


func set_rotate(flip_vertical: bool) -> void:
	sprite.flip_v = flip_vertical


func move(delta: float) -> void:
	position.x -= move_speed * delta


func stop_moving() -> void:
	CAN_MOVE = false
	position.x = self.position.x


func _on_Timer_timeout() -> void:
	move_speed += 10
