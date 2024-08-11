extends Control

@onready var score: Label = $HBoxContainer/Score
@onready var best_score: Label = $HBoxContainer/BestScore

@onready var timer: Timer = $Timer

func start_timer():
	timer.start()
	while !timer.is_stopped():
		var sec = int(timer.time_left) % 60
		var mil = int((timer.time_left) * 100) % 100
		var extra_0: String = "0" if mil < 10 else ""
		$TimeLeft.text = str(sec) + ":" + extra_0 + str(mil)
		await get_tree().process_frame
	$TimeLeft.text = "5:00"
