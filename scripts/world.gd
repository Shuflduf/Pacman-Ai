extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_mask == MOUSE_BUTTON_LEFT:
				var target = make_input_local(event).position
				#print("World: ", target)
