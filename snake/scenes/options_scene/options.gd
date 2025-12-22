extends Control


const volume_offset : float = 0.5

func _ready() -> void:	
	%VolumeSlider.set_value_no_signal(AudioServer.get_bus_volume_db(0)/volume_offset)
	%MuteBox.set_pressed_no_signal(AudioServer.is_bus_mute(0))
	set_albino_ball_python_disability()
	set_albino_boa_disability()
	set_albino_burmese_python_disability()
	set_albino_corn_snake_disability()
	set_albino_anaconda_disability()
	set_albino_king_snake_disability()
	set_albino_reticulated_python_disability()
	set_yound_tree_boa_disability()
	set_rattle_snake_disability()


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value*volume_offset)


func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))


func _on_snake_skin_panel_skin_selected(snake_path: String, snake_skin: Texture2D) -> void:
	Global.save_selected_skin(snake_path)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.previous_scene_paths.pop_front()) 


func set_albino_ball_python_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_1) >= Constants.ALBINO_BALL_PYTHON_PREREQUISITE:
		%AlbinoBallPythonPanel.set_button_disability(false)
		%AlbinoBallPythonPanel.tooltip_text = ""
		%AlbinoBallPythonLock.visible = false
	else:
		%AlbinoBallPythonPanel.set_button_disability(true)
		%AlbinoBallPythonPanel.tooltip_text = "To unlock get a high score of at least 40 on level 1."
		%AlbinoBallPythonLock.visible = true


func set_albino_boa_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_1) >= Constants.ALBINO_BOA_PREREQUISITE:
		%AlbinoBoaPanel.set_button_disability(false)
		%AlbinoBoaPanel.tooltip_text = ""
		%AlbinoBoaLock.visible = false
	else:
		%AlbinoBoaPanel.set_button_disability(true)
		%AlbinoBoaPanel.tooltip_text = "To unlock get a high score of at least 60 on level 1."
		%AlbinoBoaLock.visible = true


func set_albino_burmese_python_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_2) >= Constants.ALBINO_BURMESE_PYTHON_PREREQUISITE:
		%AlbinoBurmesePythonPanel.set_button_disability(false)
		%AlbinoBurmesePythonPanel.tooltip_text = ""
		%AlbinoBurmesePythonLock.visible = false
	else:
		%AlbinoBurmesePythonPanel.set_button_disability(true)
		%AlbinoBurmesePythonPanel.tooltip_text = "To unlock get a high score of at least 50 on level 2."
		%AlbinoBurmesePythonLock.visible = true


func set_albino_corn_snake_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_2) >= Constants.ALBINO_CORN_SNAKE_PREREQUISITE:
		%AlbinoCornSnakePanel.set_button_disability(false)
		%AlbinoCornSnakePanel.tooltip_text = ""
		%AlbinoCornSnakeLock.visible = false
	else:
		%AlbinoCornSnakePanel.set_button_disability(true)
		%AlbinoCornSnakePanel.tooltip_text = "To unlock get a high score of at least 80 on level 2."
		%AlbinoCornSnakeLock.visible = true


func set_albino_anaconda_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_3) >= Constants.ALBINO_ANACONDA_PREREQUISITE:
		%AlbinoAnacondaPanel.set_button_disability(false)
		%AlbinoAnacondaPanel.tooltip_text = ""
		%AlbinoAnacondaLock.visible = false
	else:
		%AlbinoAnacondaPanel.set_button_disability(true)
		%AlbinoAnacondaPanel.tooltip_text = "To unlock get a high score of at least 70 on level 3."
		%AlbinoAnacondaLock.visible = true


func set_albino_king_snake_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_4) >= Constants.ALBINO_CORN_SNAKE_PREREQUISITE:
		%AlbinoKingSnakePanel.set_button_disability(false)
		%AlbinoKingSnakePanel.tooltip_text = ""
		%AlbinoKingSnakeLock.visible = false
	else:
		%AlbinoKingSnakePanel.set_button_disability(true)
		%AlbinoKingSnakePanel.tooltip_text = "To unlock get a high score of at least 80 on level 4."
		%AlbinoKingSnakeLock.visible = true


func set_albino_reticulated_python_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_4) >= Constants.ALBINO_RETICULATED_PYTHON_PREREQUISITE:
		%AlbinnoReticulatedPythonPanel.set_button_disability(false)
		%AlbinnoReticulatedPythonPanel.tooltip_text = ""
		%AlbinoReticulatedPythonLock.visible = false
	else:
		%AlbinnoReticulatedPythonPanel.set_button_disability(true)
		%AlbinnoReticulatedPythonPanel.tooltip_text = "To unlock get a high score of at least 100 on level 4."
		%AlbinoReticulatedPythonLock.visible = true


func set_yound_tree_boa_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_5) >= Constants.YOUNG_TREE_BOA_PREREQUISITE:
		%YoungTreeBoaPanel.set_button_disability(false)
		%YoungTreeBoaPanel.tooltip_text = ""
		%YoungTreeBoaLock.visible = false
	else:
		%YoungTreeBoaPanel.set_button_disability(true)
		%YoungTreeBoaPanel.tooltip_text = "To unlock get a high score of at least 130 on level 5."
		%YoungTreeBoaLock.visible = true


func set_rattle_snake_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_6) >= Constants.RATTLE_SNAKE_PREREQUISITE:
		%RattleSnakePanel.set_button_disability(false)
		%RattleSnakePanel.tooltip_text = ""
		%RattleSnakeLock.visible = false
	else:
		%RattleSnakePanel.set_button_disability(true)
		%RattleSnakePanel.tooltip_text = "To unlock get a high score of at least 100 on level 6."
		%RattleSnakeLock.visible = true
