extends Control


signal options_loaded
signal level_select_loaded
const OPTIONS_PATH: String = "res://scenes/options_scene/options.tscn"
const LEVEL_SELECT_PATH: String = "res://scenes/level_select/level_select.tscn"


func _on_new_game_pressed() -> void:
	var level_select_packed: PackedScene = load(LEVEL_SELECT_PATH)
	var level_select: Node = level_select_packed.instantiate()
	add_child(level_select)
	#get_tree().change_scene_to_file("res://scenes/level_select/level_select.tscn")
	level_select_loaded.emit(level_select)


func _on_level_select_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	var options_packed: PackedScene = load(OPTIONS_PATH)
	var options: Node = options_packed.instantiate()
	add_child(options)
	#get_tree().change_scene_to_file("res://scenes/options_scene/options.tscn")
	options_loaded.emit(options)


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
