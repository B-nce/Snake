class_name  GameOverScene
extends Control


func set_score(score: String) -> void:
	%ScoreLabel.text = "Your score is: " + score


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene() 


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.previous_scene_paths.pop_front()) 
