extends Node2D


signal level_3_snake_death
var high_score: int = 0


func set_high_score(level_3_high_score: int) -> void:
	high_score = level_3_high_score
	var high_score_label: Label = get_node("Level/HighScoreLabel")
	high_score_label.text = str(high_score)


func _on_player_snake_death() -> void:
	var score_label: Label = get_node("Level/ScoreLabel")
	level_3_snake_death.emit(score_label.text.to_int())
