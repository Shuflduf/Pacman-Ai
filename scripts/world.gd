extends Node2D

var dot_pos: PackedVector2Array
@onready var ui: Control = $CanvasLayer/Control

const DOT = preload("res://scenes/dot.tscn")

var score = 0
var best_score: int = 0

func _ready() -> void:

	if FileAccess.file_exists("user://points"):
		var best_score_bits = FileAccess.get_file_as_string("user://points")
		best_score = best_score_bits.to_int()

	ui.score.text = "score: " + str(score)
	ui.best_score.text = "best: " + str(best_score)

	randomize()
	$Startup.play()
	await $Startup.finished
	await get_tree().create_timer(0.2).timeout
	$Player.dead = false
	$Player.points.connect(add_points)
	$Player.teleported.connect(func():
		$LeftPortal.restart()
		$RightPortal.restart())
	for i in $Enemies.get_children():
		i.teleported.connect(func():
			$LeftPortal.restart()
			$RightPortal.restart())


func add_points(amount: int):

	if best_score == 0:
		if FileAccess.file_exists("user://points"):
			var best_score_bits = FileAccess.get_file_as_string("user://points")
			best_score = best_score_bits.to_int()



	if amount == 30:
		ui.start_timer()


	score += amount
	ui.score.text = "score: " + str(score)

	if score > best_score:
		best_score = score
	ui.best_score.text = "best: " + str(best_score)

	#var pellet = true if amount == 10 or amount == 30 else false
	if $Dots.get_child_count() <= (1 if amount == 10 else 0):
		if $BigDots.get_child_count() <= (1 if amount == 30 else 0):
			win()

func reset():

	var best_score_file = FileAccess.open("user://points", FileAccess.WRITE)
	best_score_file.store_string(str(best_score))
	get_tree().root.add_child(load("res://scenes/world.tscn").instantiate())
	queue_free()



func _on_area_2d_area_entered(area: Area2D) -> void:
	area.owner.come_back()

func win():
	$Win.play()
	$Player.win()

	score += 1000


	await $Win.finished
	await get_tree().create_timer(0.2).timeout
	reset()
