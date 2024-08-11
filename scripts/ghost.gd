class_name Ghost
extends Node2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@export var speed = 200

var player: Node2D
var counter: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/World/Player")
	counter += randf_range(0.0, 0.5)


func _process(delta: float) -> void:
	counter += delta
	if counter > 0.5:
		counter = 0
		agent.target_position = set_target()

	var dir = global_position - agent.get_next_path_position()
	dir = dir.normalized()
	dir *= delta * speed

	position -= dir


func _on_navigation_agent_2d_link_reached(_details: Dictionary) -> void:
	position.x *= -1

func set_target() -> Vector2:
	return Vector2.ZERO
