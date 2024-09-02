extends ParallaxBackground

var CAN_MOVE = true


func _process(delta: float) -> void:
	if CAN_MOVE:
		scroll_base_offset -= Vector2(100, 0) * delta


func stop_moving() -> void:
	scroll_base_offset = Vector2.ZERO
	CAN_MOVE = not CAN_MOVE
