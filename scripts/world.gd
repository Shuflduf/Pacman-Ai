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
	await get_tree().create_timer(0.5).timeout
	find_child("Player").dead = false
	find_child("Player").points.connect(add_points)

func add_points(amount: int):

	if best_score == 0:
		if FileAccess.file_exists("user://points"):
			var best_score_bits = FileAccess.get_file_as_string("user://points")
			best_score = best_score_bits.to_int()

	score += amount
	ui.score.text = "score: " + str(score)

	if score > best_score:
		best_score = score
	ui.best_score.text = "best: " + str(best_score)

func reset():

	var best_score_file = FileAccess.open("user://points", FileAccess.WRITE)
	best_score_file.store_string(str(best_score))
	get_tree().root.add_child(load("res://scenes/world.tscn").instantiate())
	queue_free()

