extends Node

const SAVE_PATH: String = "user://snake.save"
var previous_scene_paths: Array[String] 
var saved_data: Dictionary = {
	Constants.DATA_HIGHSCORES: {
		Constants.DATA_LVL_1: 0,
		Constants.DATA_LVL_2: 0, 
		Constants.DATA_LVL_3: 0,
		Constants.DATA_LVL_4: 0,
		Constants.DATA_LVL_5: 0,
		Constants.DATA_LVL_6: 0,
		},
	Constants.DATA_SELECTED_SKIN_PATH_1: "res://assets/sprites/ball_python.png",
	Constants.DATA_SELECTED_SKIN_PATH_2: "res://assets/sprites/burmese_python.png",
	Constants.DATA_SELECTED_SKIN_PATH_3: "res://assets/sprites/corn_snake.png",
	Constants.DATA_SELECTED_SKIN_PATH_4: "res://assets/sprites/green_anaconda.png"
	}
var number_of_players = 4


func get_high_score(level_name: String) -> int:
	return saved_data[Constants.DATA_HIGHSCORES][level_name]


func save_high_score(level_name: String, score: int) -> void:
	saved_data[Constants.DATA_HIGHSCORES][level_name] = score
	_save_all_data()


func get_selected_skin(player_number: int) -> String:
	return saved_data[Constants.DATA_SELECTED_SKIN_PATH + str(player_number)]


func save_selected_skin(skin_path: String, player_number: int) -> void:
	saved_data[Constants.DATA_SELECTED_SKIN_PATH + str(player_number)] = skin_path
	_save_all_data()
	

func _ready() -> void:
	_load_all_data()


func _save_all_data() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(saved_data)
	file.close()


func _load_all_data() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		saved_data = file.get_var()
		file.close()
