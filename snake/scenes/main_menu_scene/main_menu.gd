extends Control


func _on_new_game_pressed() -> void:
	Globals.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_select/level_select.tscn")


func _on_level_select_pressed() -> void:
	Globals.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_select/level_select.tscn")


func _on_options_pressed() -> void:
	Globals.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/options_scene/options.tscn")


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
