class_name Ghost
extends CharacterBody2D

@onready var tree: AnimationTree = $AnimationTree
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@export var speed = 200
@export var corner = Vector2.ZERO

var player: Node2D
var counter: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	counter += randf_range(0.0, 0.5)


func _process(delta: float) -> void:
	if !player:
		player = get_tree().get_first_node_in_group("Player")
	if player.dead:
		return
	counter += delta
	if counter > 0.5:
		counter = 0
		agent.target_position = set_target()

	var dir = global_position - agent.get_next_path_position()
	dir = -dir.normalized()
	tree.set("parameters/blend_position", dir * Vector2(1, -1))
	velocity = dir * speed

	move_and_slide()


func _on_navigation_agent_2d_link_reached(_details: Dictionary) -> void:
	position.x *= -1

func set_target() -> Vector2:
	return Vector2.ZERO


func _on_hitbox_area_entered(area: Area2D) -> void:
	area.owner.die()
