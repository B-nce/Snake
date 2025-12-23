extends Control


const volume_offset : float = 0.5

var skin_dictionary : Dictionary = {}

func _ready() -> void:	
	%VolumeSlider.set_value_no_signal(AudioServer.get_bus_volume_db(0)/volume_offset)
	%MuteBox.set_pressed_no_signal(AudioServer.is_bus_mute(0))
	if Global.get_high_score(Constants.DATA_LVL_1) >= Constants.ALBINO_BALL_PYTHON_PREREQUISITE:
		%AlbinoBallPythonPanel.set_button_disability(false)
		%AlbinoBallPythonLock.visible = false
	else:
		%AlbinoBallPythonPanel.set_button_disability(true)
		%AlbinoBallPythonLock.visible = true
		%AlbinoBallPythonLock.offset.x += %AlbinoBallPythonPanel.size.x/2
		%AlbinoBallPythonLock.offset.y += %AlbinoBallPythonPanel.size.y/4
		
	if Global.get_high_score(Constants.DATA_LVL_1) >= Constants.ALBINO_BOA_PREREQUISITE:
		%AlbinoBoaPanel.set_button_disability(false)
		%AlbinoBoaLock.visible = false
	else:
		%AlbinoBoaPanel.set_button_disability(true)
		%AlbinoBoaLock.visible = true
		%AlbinoBoaLock.offset.x += %AlbinoBoaPanel.size.x/2
		%AlbinoBoaLock.offset.y += %AlbinoBoaPanel.size.y/4
		
	if Global.get_high_score(Constants.DATA_LVL_2) >= Constants.ALBINO_BURMESE_PYTHON_PREREQUISITE:
		%AlbinoBurmesePythonPanel.set_button_disability(false)
		%AlbinoBurmesePythonLock.visible = false
	else:
		%AlbinoBurmesePythonPanel.set_button_disability(true)
		%AlbinoBurmesePythonLock.visible = true
		%AlbinoBurmesePythonLock.offset.x += %AlbinoBurmesePythonPanel.size.x/2
		%AlbinoBurmesePythonLock.offset.y += %AlbinoBurmesePythonPanel.size.y/4
	
	if Global.get_high_score(Constants.DATA_LVL_2) >= Constants.ALBINO_CORN_SNAKE_PREREQUISITE:
		%AlbinoCornSnakePanel.set_button_disability(false)
		%AlbinoCornSnakeLock.visible = false
	else:
		%AlbinoCornSnakePanel.set_button_disability(true)
		%AlbinoCornSnakeLock.visible = true
		%AlbinoCornSnakeLock.offset.x += %AlbinoCornSnakePanel.size.x/2
		%AlbinoCornSnakeLock.offset.y += %AlbinoCornSnakePanel.size.y/4
	
	if Global.get_high_score(Constants.DATA_LVL_3) >= Constants.ALBINO_ANACONDA_PREREQUISITE:
		%AlbinoAnacondaPanel.set_button_disability(false)
		%AlbinoAnacondaLock.visible = false
	else:
		%AlbinoAnacondaPanel.set_button_disability(true)
		%AlbinoAnacondaLock.visible = true
		%AlbinoAnacondaLock.offset.x += %AlbinoAnacondaPanel.size.x/2
		%AlbinoAnacondaLock.offset.y += %AlbinoAnacondaPanel.size.y/4
	
	if Global.get_high_score(Constants.DATA_LVL_3) >= Constants.ALBINO_CORN_SNAKE_PREREQUISITE:
		%AlbinoKingSnakePanel.set_button_disability(false)
		%AlbinoKingSnakeLock.visible = false
	else:
		%AlbinoKingSnakePanel.set_button_disability(true)
		%AlbinoKingSnakeLock.visible = true
		%AlbinoKingSnakeLock.offset.x += %AlbinoKingSnakePanel.size.x/2
		%AlbinoKingSnakeLock.offset.y += %AlbinoKingSnakePanel.size.y/4
	
	if Global.get_high_score(Constants.DATA_LVL_3) >= Constants.ALBINO_RETICULATED_PYTHON_PREREQUISITE:
		%AlbinnoReticulatedPythonPanel.set_button_disability(false)
		%AlbinoReticulatedPythonLock.visible = false
	else:
		%AlbinnoReticulatedPythonPanel.set_button_disability(true)
		%AlbinoReticulatedPythonLock.visible = true
		%AlbinoReticulatedPythonLock.offset.x += %AlbinnoReticulatedPythonPanel.size.x/2
		%AlbinoReticulatedPythonLock.offset.y += %AlbinnoReticulatedPythonPanel.size.y/4
	
	if Global.get_high_score(Constants.DATA_LVL_3) >= Constants.YOUNG_TREE_BOA_PREREQUISITE:
		%YoungTreeBoaPanel.set_button_disability(false)
		%YoungTreeBoaLock.visible = false
	else:
		%YoungTreeBoaPanel.set_button_disability(true)
		%YoungTreeBoaLock.visible = true
		%YoungTreeBoaLock.offset.x += %YoungTreeBoaPanel.size.x/2
		%YoungTreeBoaLock.offset.y += %YoungTreeBoaPanel.size.y/4
	build_list()
	$"TabContainer/Skin selector".set_skin_dictionary(skin_dictionary)
	load_skins()


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


func _on_back_button_pressed() -> void:
	for snake_skin_selector: SnakeSkinSelector in %SnakeSkinSelectorsContainer.get_children():
		var skin = skin_dictionary[snake_skin_selector.skin_index]
		Global.save_selected_skin(skin,snake_skin_selector.player_number)
	get_tree().change_scene_to_file(Global.previous_scene_paths.pop_front()) 


func build_list() -> void:
	var i: int = 0
	for child: SnakeSkinPanel in %ContainerColumn.get_children():
		skin_dictionary[i] = child.skin_path
		i += 1
	for child: SnakeSkinPanel in %ContainerColumn2.get_children():
		if !child.get_button_disability():
			skin_dictionary[i] = child.skin_path
			i += 1


func load_skins() -> void:
	for snake_skin_selector: SnakeSkinSelector in %SnakeSkinSelectorsContainer.get_children():
		var skin_path = Global.get_selected_skin(snake_skin_selector.player_number)
		snake_skin_selector.set_index(skin_dictionary.find_key(skin_path))
