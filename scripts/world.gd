extends Node2D

@onready var enemy: Sprite2D = $Enemy
@onready var agent: NavigationAgent2D = $Enemy/NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = enemy.global_position - agent.get_next_path_position()
	dir = dir.normalized()
	dir *= delta * 300

	enemy.position -= dir


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_mask == MOUSE_BUTTON_LEFT:
				var target = make_input_local(event).position
				agent.target_position = target
				#print(target)


func _on_navigation_agent_2d_link_reached(details: Dictionary) -> void:
	#if details["position"].x > 0:
	enemy.position.x *= -1
	#print(details["position"])
