extends Node2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var speed = 200


var last_dir: Vector2

func _process(delta: float) -> void:
	var dir = global_position - agent.get_next_path_position()

	if dir.length_squared() < 1.0:
		return

	dir = dir.normalized()
	last_dir = dir
	dir *= delta * speed
	sprite.rotation = atan2(last_dir.y, last_dir.x)
	sprite.rotation += PI

	print(sprite.rotation)

	position -= dir


func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				var target = get_parent().make_input_local(event).position
				agent.target_position = target


func _on_navigation_agent_2d_link_reached(_details: Dictionary) -> void:
	position.x *= -1


func _on_dot_eater_area_entered(area: Area2D) -> void:
	area.owner.queue_free()
