extends Ghost



func set_target():
	var target = player.global_position - (player.last_dir * 200)
	return target
