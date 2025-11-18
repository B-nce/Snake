extends Control

func _ready() -> void:
	if Global.get_high_score(Constants.DATA_LVL_1) >= Constants.LVL_2_PREREQUISITE:
		%Level2Button.disabled = false
		%Level2Lock.visible = false
	else:
		%Level2Button.disabled = true
		%Level2Lock.offset.x += 196
		%Level2Lock.offset.y += %Level2Button.size.y/4
	if Global.get_high_score(Constants.DATA_LVL_2) >= Constants.LVL_3_PREREQUISITE:
		%Level3Button.disabled = false
		%Level3Lock.visible = false
	else:
		%Level3Button.disabled = true
		%Level3Lock.offset.x += 196
		%Level3Lock.offset.y += %Level3Button.size.y/4


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
