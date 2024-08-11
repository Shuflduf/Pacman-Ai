extends Node2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@export var speed = 200

var last_dir: Vector2

func _process(delta: float) -> void:
	var dir = global_position - agent.get_next_path_position()
	if dir.is_equal_approx(Vector2.ZERO):
		return
	dir = dir.normalized()
	last_dir = dir
	dir *= delta * speed


	print(last_dir)

	position -= dir


func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			var target = get_parent().make_input_local(event).position
			agent.target_position = target


func _on_navigation_agent_2d_link_reached(_details: Dictionary) -> void:
	position.x *= -1


func _on_dot_eater_area_entered(area: Area2D) -> void:
	area.owner.queue_free()
