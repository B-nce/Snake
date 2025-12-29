extends Control


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.previous_scene_paths.pop_front()) 


func _on_two_player_button_pressed() -> void:
	Global.number_of_players = 2
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_select/level_select.tscn")


func _on_three_player_button_pressed() -> void:
	Global.number_of_players = 3
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_select/level_select.tscn")


func _on_four_player_button_pressed() -> void:
	Global.number_of_players = 4
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_select/level_select.tscn")
