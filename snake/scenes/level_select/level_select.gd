extends Control

signal level_1_started
signal level_2_started
signal level_3_started
const LEVEL_1_PATH = "res://scenes/level_1/level_1.tscn"
const LEVEL_2_PATH = "res://scenes/level_2/level_2.tscn"
const LEVEL_3_PATH = "res://scenes/level_3/level_3.tscn"


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_scene/main_menu.tscn")

func _on_back_button_pressed() -> void:
	self.queue_free()


func _on_level_1_button_pressed() -> void:
	var level_1_packed: PackedScene = load(LEVEL_1_PATH)
	var level_1: Node = level_1_packed.instantiate()
	add_child(level_1)
	level_1_started.emit(level_1)
	
func _on_level_2_button_pressed() -> void:
	var level_2_packed: PackedScene = load(LEVEL_2_PATH)
	var level_2: Node = level_2_packed.instantiate()
	add_child(level_2)
	level_2_started.emit(level_2)


func _on_level_3_button_pressed() -> void:
	var level_3_packed: PackedScene = load(LEVEL_3_PATH)
	var level_3: Node = level_3_packed.instantiate()
	add_child(level_3)
	level_3_started.emit(level_3)
