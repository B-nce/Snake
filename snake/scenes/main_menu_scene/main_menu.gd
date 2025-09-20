extends Control


signal options_loaded
const OPTIONS_PATH: String = "res://scenes/options_scene/options.tscn"


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1/level_1.tscn")


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
