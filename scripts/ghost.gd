class_name Ghost
extends CharacterBody2D

@onready var timer: Timer = $Timer
@onready var tree: AnimationTree = $AnimationTree
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@export var speed = 200
@export var corner = Vector2.ZERO

var player: Node2D
var counter: float
var panicing = false
var speed_mult: float = 1.0
var saved_colour: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	saved_colour = $Body.modulate
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
		if !$Body.visible:
			agent.target_position = Vector2.ZERO
		if panicing:
			agent.target_position = corner
		else:
			agent.target_position = set_target()


	var dir = global_position - agent.get_next_path_position()
	dir = -dir.normalized()
	tree.set("parameters/blend_position", dir * Vector2(1, -1))
	velocity = dir * speed * speed_mult

	move_and_slide()


func _on_navigation_agent_2d_link_reached(_details: Dictionary) -> void:
	position.x *= -1

func set_target() -> Vector2:
	return Vector2.ZERO


func _on_hitbox_area_entered(area: Area2D) -> void:
	if !panicing:
		area.owner.die()
	else:
		if !$Body.visible:
			return
		collision_mask = 0
		collision_layer = 0
		$Body.hide()
		speed_mult = 3
		area.owner.streak += 1
		area.owner.points.emit(area.owner.streak * 100)
		$TempLabel.position.y = -40
		$TempLabel.text = str(area.owner.streak * 100)
		$TempLabel.modulate.a = 1
		$TempLabel.global_position = global_position
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
		tween.tween_property($TempLabel, "position:y", $TempLabel.position.y - 100, 1)
		tween.tween_property($TempLabel, "modulate:a", 0, 0.3)



func come_back():
	collision_mask = 3
	collision_layer = 3
	$Body.show()
	_on_timer_timeout()

func _on_timer_timeout() -> void:
	panicing = false
	speed_mult = 1
	$Body.modulate = saved_colour
