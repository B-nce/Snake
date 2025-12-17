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
	Constants.DATA_SELECTED_SKIN_PATH: "res://assets/sprites/ball_python.png"
	}


func get_high_score(level_name: String) -> int:
	return saved_data[Constants.DATA_HIGHSCORES][level_name]


func save_high_score(level_name: String, score: int) -> void:
	saved_data[Constants.DATA_HIGHSCORES][level_name] = score
	_save_all_data()


func get_selected_skin() -> String:
	return saved_data[Constants.DATA_SELECTED_SKIN_PATH]


func save_selected_skin(skin_path: String) -> void:
	saved_data[Constants.DATA_SELECTED_SKIN_PATH] = skin_path
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
