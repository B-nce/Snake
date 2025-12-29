extends Control


func _on_single_player_pressed() -> void:
	Global.number_of_players = 1
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_select/level_select.tscn")


func _on_multi_player_pressed() -> void:
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/player_select/player_select.tscn")


func _on_options_pressed() -> void:
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/options_scene/options.tscn")


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
