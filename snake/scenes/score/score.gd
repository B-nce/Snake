class_name Score
extends Node2D

@export var player: Player
@export var time_label_size: int = 30

@onready var time_label: Line2D = %TimeLabel as Line2D
@onready var delta_elapsed: float = 0.0
@onready var player_number: int = player.player_number #we need this separately because the player can despawn after death

var score: int
var grid: AStarGrid2D
var horizontal_offset: float
var grid_scale: Vector2


func _ready() -> void:
	$PlayerNumber.text = "P" + str(player.player_number)


func _process(delta: float) -> void:
	delta_elapsed += delta
	if(delta_elapsed >= 0.1):
		delta_elapsed -= 0.1
		if(!$ScoreTimer.is_stopped()):
			_decrease_time_label(20/$ScoreTimer.wait_time)


func restart_score(new_apple_position: Vector2) -> void:
	delta_elapsed = 0.0
	$ScoreTimer.set_wait_time(_calculate_distance(new_apple_position, player.position))
	_reset_time_label()
	$ScoreTimer.start()


func update_score() -> void:
	if !$ScoreTimer.is_stopped():
		var time_elapsed = $ScoreTimer.wait_time - $ScoreTimer.time_left
		$ScoreTimer.stop()
		score += _calculate_score_from_time($ScoreTimer.wait_time, time_elapsed)
		%ScoreLabel.text = str(score)


func load_high_score(level_name: String) -> void:
	%HighScoreLabel.text = str(Global.get_high_score(level_name))


func hide_high_score() -> void:
	$HighScoreBackground.hide()


func _calculate_distance(a_pos: Vector2, p_pos: Vector2) -> int:
	p_pos.x -= horizontal_offset
	var a_grid_pos: Vector2 = floor(a_pos/(Constants.SPRITE_SIZE))
	var p_grid_pos: Vector2 = floor(p_pos/(Constants.SPRITE_SIZE * grid_scale))
	var road: Array[Vector2i] = grid.get_id_path(p_grid_pos,a_grid_pos)
	return road.size()-1


func _calculate_score_from_time(wait_time: int, time_elapsed: float) -> int:
	if time_elapsed < wait_time/4:
		return 3
	else:
		return 2 if time_elapsed < wait_time/2 else 1


func _decrease_time_label(point_size) -> void:
	if(time_label.points[1].y < time_label.points[0].y):
		time_label.points[1].y += point_size
	if(time_label.points[1].y > time_label.points[0].y):
		time_label.points[1].y = time_label.points[0].y


func _reset_time_label() -> void:
	time_label.points[1].y = time_label_size
