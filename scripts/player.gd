extends Node2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D


func _process(delta: float) -> void:
	var dir = global_position - agent.get_next_path_position()
	dir = dir.normalized()
	dir *= delta * 300

	position -= dir


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_mask == MOUSE_BUTTON_LEFT:
				var target = get_parent().make_input_local(event).position
				agent.target_position = target
				#print("Player: ", target)


func _on_navigation_agent_2d_link_reached(_details: Dictionary) -> void:
	position.x *= -1
