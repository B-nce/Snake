extends Control

func _ready() -> void:
	set_level_2_disability()
	set_level_3_disability()
	set_level_4_disability()
	set_level_5_disability()
	set_level_6_disability()


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


func _on_level_4_button_pressed() -> void:
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_4/level_4.tscn")


func _on_level_5_button_pressed() -> void:
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_5/level_5.tscn")


func _on_level_6_button_pressed() -> void:
	Global.previous_scene_paths.push_front(self.scene_file_path) 
	get_tree().change_scene_to_file("res://scenes/level_6/level_6.tscn")
func set_level_2_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_1) >= Constants.LVL_2_PREREQUISITE:
		%Level2Button.disabled = false
		%Level2Button.tooltip_text = ""
		%Level2Lock.visible = false
	else:
		%Level2Button.tooltip_text = "To unlock get a high score of at least 50 on level 1."
		%Level2Button.disabled = true


func set_level_3_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_2) >= Constants.LVL_3_PREREQUISITE:
		%Level3Button.disabled = false
		%Level3Button.tooltip_text = ""
		%Level3Lock.visible = false
	else:
		%Level3Button.tooltip_text = "To unlock get a high score of at least 60 on level 2."
		%Level3Button.disabled = true


func set_level_4_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_4) >= Constants.LVL_4_PREREQUISITE:
		%Level4Button.disabled = false
		%Level4Button.tooltip_text = ""
		%Level4Lock.visible = false
	else:
		%Level4Button.tooltip_text = "To unlock get a high score of at least 70 on level 3."
		%Level4Button.disabled = true


func set_level_5_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_5) >= Constants.LVL_5_PREREQUISITE:
		%Level5Button.disabled = false
		%Level5Button.tooltip_text = ""
		%Level5Lock.visible = false
	else:
		%Level5Button.tooltip_text = "To unlock get a high score of at least 90 on level 4."
		%Level5Button.disabled = true


func set_level_6_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_6) >= Constants.LVL_6_PREREQUISITE:
		%Level6Button.disabled = false
		%Level6Button.tooltip_text = ""
		%Level6Lock.visible = false
	else:
		%Level6Button.tooltip_text = "To unlock get a high score of at least 150 on level 5."
		%Level6Button.disabled = true
