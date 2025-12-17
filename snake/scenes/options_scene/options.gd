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
		%AlbinoBallPythonLock.visible = false
	else:
		%AlbinoBallPythonPanel.set_button_disability(true)
		%AlbinoBallPythonLock.visible = true


func set_albino_boa_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_1) >= Constants.ALBINO_BOA_PREREQUISITE:
		%AlbinoBoaPanel.set_button_disability(false)
		%AlbinoBoaLock.visible = false
	else:
		%AlbinoBoaPanel.set_button_disability(true)
		%AlbinoBoaLock.visible = true


func set_albino_burmese_python_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_2) >= Constants.ALBINO_BURMESE_PYTHON_PREREQUISITE:
		%AlbinoBurmesePythonPanel.set_button_disability(false)
		%AlbinoBurmesePythonLock.visible = false
	else:
		%AlbinoBurmesePythonPanel.set_button_disability(true)
		%AlbinoBurmesePythonLock.visible = true


func set_albino_corn_snake_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_2) >= Constants.ALBINO_CORN_SNAKE_PREREQUISITE:
		%AlbinoCornSnakePanel.set_button_disability(false)
		%AlbinoCornSnakeLock.visible = false
	else:
		%AlbinoCornSnakePanel.set_button_disability(true)
		%AlbinoCornSnakeLock.visible = true


func set_albino_anaconda_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_3) >= Constants.ALBINO_ANACONDA_PREREQUISITE:
		%AlbinoAnacondaPanel.set_button_disability(false)
		%AlbinoAnacondaLock.visible = false
	else:
		%AlbinoAnacondaPanel.set_button_disability(true)
		%AlbinoAnacondaLock.visible = true


func set_albino_king_snake_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_4) >= Constants.ALBINO_CORN_SNAKE_PREREQUISITE:
		%AlbinoKingSnakePanel.set_button_disability(false)
		%AlbinoKingSnakeLock.visible = false
	else:
		%AlbinoKingSnakePanel.set_button_disability(true)
		%AlbinoKingSnakeLock.visible = true


func set_albino_reticulated_python_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_4) >= Constants.ALBINO_RETICULATED_PYTHON_PREREQUISITE:
		%AlbinnoReticulatedPythonPanel.set_button_disability(false)
		%AlbinoReticulatedPythonLock.visible = false
	else:
		%AlbinnoReticulatedPythonPanel.set_button_disability(true)
		%AlbinoReticulatedPythonLock.visible = true


func set_yound_tree_boa_disability() -> void:
	if Global.get_high_score(Constants.DATA_LVL_5) >= Constants.YOUNG_TREE_BOA_PREREQUISITE:
		%YoungTreeBoaPanel.set_button_disability(false)
		%YoungTreeBoaLock.visible = false
	else:
		%YoungTreeBoaPanel.set_button_disability(true)
		%YoungTreeBoaLock.visible = true
