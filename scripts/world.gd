extends Node2D

var dot_pos: PackedVector2Array

const DOT = preload("res://scenes/dot.tscn")

func _ready() -> void:
	randomize()
	await get_tree().create_timer(0.5).timeout
	find_child("Player").dead = false


func reset():
	get_tree().root.add_child(load("res://scenes/world.tscn").instantiate())
	queue_free()
