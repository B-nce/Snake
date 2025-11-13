class_name Global
extends Node

const SAVE_PATH: String = "user://snake.save"
var high_Score_level_1: int = 0
var high_Score_level_2: int = 0
var high_Score_level_3: int = 0
var selected_skin_path: String = "res://assets/sprites/ball_python.png"
var snake_skin_texture: Texture2D = load(selected_skin_path)
var previous_scene_paths: Array[String] 

func _ready() -> void:
	load_data()


func load_data() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		high_Score_level_1 = file.get_var()
		high_Score_level_2 = file.get_var()
		high_Score_level_3 = file.get_var()
		selected_skin_path = file.get_var()
		snake_skin_texture = load(selected_skin_path)


func save_data() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(high_Score_level_1)
	file.store_var(high_Score_level_2)
	file.store_var(high_Score_level_3)
	file.store_var(selected_skin_path)
	pass
