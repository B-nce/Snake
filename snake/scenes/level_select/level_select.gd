extends Control


func _ready() -> void:
	if Global.number_of_players > 1:
		return
	set_level_disability()


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


func set_level_disability() -> void:
	if Global.number_of_players > 1:
		return
	var lock_texture = load("res://assets/sprites/lock.png")
	var levels = %LevelContainer.get_children()
	print(levels)
	for i in range(0,levels.size()-1):
		if Constants.LVL_PREREQUISITES[Constants.DATA_LVL + str(i + 2)] <= Global.get_high_score(Constants.DATA_LVL + str(i + 1)):
			levels[i+1].tooltip_text = ""
		else:
			var texture_rect: TextureRect = TextureRect.new()
			texture_rect.texture = lock_texture
			levels[i+1].add_child(texture_rect)
			texture_rect.set_anchors_preset(Control.PRESET_CENTER_TOP, true)
			texture_rect.scale.x = 2
			texture_rect.scale.y = 2
			texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			levels[i+1].disabled = true
			levels[i+1].tooltip_text = "To unlock get a high score of at least " + str(Constants.LVL_PREREQUISITES[Constants.DATA_LVL + str(i + 2)]) + " on level " + str(i + 1)
