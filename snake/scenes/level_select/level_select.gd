extends Control

signal level_1_started
const LEVEL_1_PATH = "res://scenes/level_1/level_1.tscn"


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_scene/main_menu.tscn")

func _on_back_button_pressed() -> void:
	self.queue_free()
	#get_tree().change_scene_to_file("res://scenes/main_menu_scene/main_menu.tscn")


func _on_level_1_button_pressed() -> void:
	var level_1_packed: PackedScene = load(LEVEL_1_PATH)
	var level_1: Node = level_1_packed.instantiate()
	add_child(level_1)
	#get_tree().change_scene_to_file("res://scenes/level_select/level_select.tscn")
	level_1_started.emit(level_1)
	#get_tree().change_scene_to_file("res://scenes/level_1/level_1.tscn")
	#level_1_start.emit()
