extends Ghost

var red: Ghost
var pink: Ghost

func _ready() -> void:
	super()
	pink = get_parent().find_child("Pink")
	red = get_parent().find_child("Red")


func set_target() -> Vector2:
	var dir = pink.set_target() - red.global_position
	dir *= 2

	return dir
