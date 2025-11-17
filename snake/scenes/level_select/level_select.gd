extends Control

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.previous_scene_paths.pop_front()) 


func _on_level_1_button_pressed() -> void:
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_1/level_1.tscn")


func _on_level_2_button_pressed() -> void:
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_2/level_2.tscn")


func _on_level_3_button_pressed() -> void:
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_3/level_3.tscn")
