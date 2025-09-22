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
	print(scenes)
	main_menu.options_loaded.connect(options_loaded)
	main_menu.level_select_loaded.connect(level_select_loaded)
	load_data()
	pass


func options_loaded(main_menu: Node) -> void:
	var menu = get_child(0)
	options = menu.get_child(-1)
	print(options)
	options.skin_selected.connect(update_skin)
	pass
	

func level_select_loaded(level_select: Node) -> void:
	var menu = get_child(0)
	level_select = menu.get_child(-1)
	print(level_select)
	level_select.level_1_start.connect(set_level_1_skin)
	pass


func update_skin(new_path: String, new_texture: Texture2D) -> void:
	print("ez lehetetlen")
	snake_skin_texture = new_texture
	selected_skin_path = new_path
	save_data()
	pass


func set_level_1_skin(level_1: Node) -> void:
	print("ez lehetetlen")
	var player = level_1.get_child(1)
	level_1.get_child(1).set_snake_skin(snake_skin_texture)
	pass


func load_data() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		high_Score_level_1 = file.get_var()
		high_Score_level_2 = file.get_var()
		high_Score_level_3 = file.get_var()
		selected_skin_path = file.get_var()
		snake_skin_texture = load(selected_skin_path)
	pass


func save_data() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(high_Score_level_1)
	file.store_var(high_Score_level_2)
	file.store_var(high_Score_level_3)
	file.store_var(selected_skin_path)
	pass
