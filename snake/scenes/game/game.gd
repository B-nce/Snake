extends Node

const SAVE_PATH: String = "user://snake.save"
const MAIN_MENU_PATH: String = "res://scenes/main_menu_scene/main_menu.tscn"
var options: Control
var high_Score_level_1: int = 0
var high_Score_level_2: int = 0
var high_Score_level_3: int = 0
var selected_skin_path: String = "res://assets/sprites/ball_python.png"
var snake_skin_texture: Texture2D = load(selected_skin_path)

func _ready() -> void:
	var main_menu_packed: PackedScene = load(MAIN_MENU_PATH)
	var main_menu: Node = main_menu_packed.instantiate()
	add_child(main_menu)
	var scenes = get_tree().current_scene
	main_menu.options_loaded.connect(on_options_loaded)
	main_menu.level_select_loaded.connect(on_level_select_loaded)
	load_data()


func on_options_loaded(main_menu: Node) -> void:
	var menu = get_child(0)
	options = menu.get_child(-1)
	options.skin_selected.connect(on_skin_selected)
	pass
	

func on_level_select_loaded(level_select: Node) -> void:
	var menu = get_child(0)
	level_select = menu.get_child(-1)
	level_select.level_1_started.connect(on_level_1_started)
	level_select.level_2_started.connect(on_level_2_started)
	level_select.level_3_started.connect(on_level_3_started)
	pass


func on_skin_selected(new_path: String, new_texture: Texture2D) -> void:
	snake_skin_texture = new_texture
	selected_skin_path = new_path
	save_data()


func on_level_1_started(level_1: Node) -> void:
	var player = level_1.get_child(0)
	level_1.level_1_snake_death.connect(on_level_1_snake_death)
	player.set_snake_skin(snake_skin_texture)
	level_1.set_high_score(high_Score_level_1)


func on_level_1_snake_death(score: int) -> void:
	if high_Score_level_1 < score:
		high_Score_level_1 = score
		save_data()


func on_level_2_started(level_2: Node) -> void:
	var player = level_2.get_child(0)
	level_2.level_2_snake_death.connect(on_level_2_snake_death)
	player.set_snake_skin(snake_skin_texture)
	level_2.set_high_score(high_Score_level_2)


func on_level_2_snake_death(score: int) -> void:
	if high_Score_level_2 < score:
		high_Score_level_2 = score
		save_data()


func on_level_3_started(level_3: Node) -> void:
	var player = level_3.get_child(0)
	level_3.level_3_snake_death.connect(on_level_3_snake_death)
	player.set_snake_skin(snake_skin_texture)
	level_3.set_high_score(high_Score_level_3)


func on_level_3_snake_death(score: int) -> void:
	if high_Score_level_3 < score:
		high_Score_level_3 = score
		save_data()


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
