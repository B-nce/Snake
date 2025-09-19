extends Node

const SAVE_PATH: String = "user://snake.save"
var high_Score_level_1: int = 0
var high_Score_level_2: int = 0
var high_Score_level_3: int = 0
var selected_skin: String = "res://assets/sprites/ball_python.png"

func _ready() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_scene/main_menu.tscn")
	pass


func load_data() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		high_Score_level_1 = file.get_var()
		high_Score_level_2 = file.get_var()
		high_Score_level_3 = file.get_var()
		selected_skin = file.get_var()
	pass


func save_data() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(high_Score_level_1)
	file.store_var(high_Score_level_2)
	file.store_var(high_Score_level_3)
	file.store_var(selected_skin)
	pass
