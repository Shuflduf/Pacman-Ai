extends Node2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@export var speed = 200

var player: Node2D
var counter: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/World/Player")


func _physics_process(delta: float) -> void:
	counter += 1
	if counter % 10 == 0:
		agent.target_position = player.global_position

	var dir = global_position - agent.get_next_path_position()
	dir = dir.normalized()
	dir *= delta * 300

	position -= dir


func _on_navigation_agent_2d_link_reached(_details: Dictionary) -> void:
	position.x *= -1
