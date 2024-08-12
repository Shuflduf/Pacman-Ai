extends Node2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var speed = 200

signal points(amount: int)

var dead = true
var last_dir: Vector2
var streak = 0

var speed_mult := 1.0

func _process(delta: float) -> void:
	if dead:
		return

	var dir = global_position - agent.get_next_path_position()

	if dir.length_squared() < 1.0:
		$WakaWaka.stop()
		return

	if !$WakaWaka.playing:
		$WakaWaka.play()

	dir = dir.normalized()
	last_dir = dir
	dir *= delta * speed * speed_mult
	sprite.rotation = atan2(last_dir.y, last_dir.x)
	sprite.rotation += PI
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
	if area.owner.name.begins_with("BigDot"):
		for i in get_tree().get_nodes_in_group("Ghost"):
			streak = 0
			i.panicing = true
			i.get_node("Body").modulate = Color.DARK_BLUE
			i.timer.start()
			i.speed_mult = 0.647
			speed_mult = 1.06
			get_tree().create_timer(5).timeout.connect(func(): speed_mult = 1)


		points.emit(30)
	else:
		points.emit(10)
	area.owner.queue_free()

func die():
	dead = true
	await get_tree().create_timer(0.5).timeout
	$GPUParticles2D.restart()
	sprite.hide()
	await $GPUParticles2D.finished
	await get_tree().create_timer(0.5).timeout
	get_parent().reset()

