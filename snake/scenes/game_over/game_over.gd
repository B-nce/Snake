class_name  GameOverScene
extends Control


func set_scores(scores: Array[Score], is_high_score: bool) -> void:
	var text: String = "Score\n" if Global.number_of_players == 1 else "Scores\n"
	scores.sort_custom(func(a: Score, b: Score): return a.score > b.score)
	for score in scores:
		if score.player_number <= Global.number_of_players:
			text += " p{0}: {1} ".format([score.player_number, score.score])

	%ScoreLabel.text = text
	%HighScoreLabel.visible = is_high_score


func _on_retry_button_pressed() -> void:
	self.queue_free()
	get_tree().reload_current_scene() 


func _on_back_button_pressed() -> void:
	self.queue_free()
	get_tree().change_scene_to_file(Global.previous_scene_paths.pop_front()) 
