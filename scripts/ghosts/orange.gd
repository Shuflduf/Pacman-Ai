extends Ghost

func set_target() -> Vector2:
	if global_position.distance_squared_to(player.global_position) > 104858:
		return player.global_position
	return corner
