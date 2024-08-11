extends Ghost

@export var corner = Vector2(-800, 928)

func set_target() -> Vector2:
	if global_position.distance_squared_to(player.global_position) > 104858:
		return player.global_position
	return corner
