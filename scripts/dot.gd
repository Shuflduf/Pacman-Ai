extends Node2D

func die() -> void:
	$GPUParticles2D.restart()
	$Sprite2D.hide()
	await $GPUParticles2D.finished
	queue_free()
