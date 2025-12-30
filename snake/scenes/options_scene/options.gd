extends Control


var skin_dictionary : Dictionary = {}


func _ready() -> void:
	%VolumeSlider.set_value_no_signal(AudioServer.get_bus_volume_db(0) / Constants.VOLUME_OFFSET)
	%MuteBox.set_pressed_no_signal(AudioServer.is_bus_mute(0))
	set_skin_disablity()
	build_list()
	load_skins()


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value * Constants.VOLUME_OFFSET)
	Global.save_volume(value)


func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)
	Global.save_is_muted(toggled_on)


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
	$"TabContainer/Skin selector".set_skin_dictionary(skin_dictionary)

func load_skins() -> void:
	for snake_skin_selector: SnakeSkinSelector in %SnakeSkinSelectorsContainer.get_children():
		var skin_path = Global.get_selected_skin(snake_skin_selector.player_number)
		snake_skin_selector.set_index(skin_dictionary.find_key(skin_path))


func set_skin_disablity() -> void:
	var locked_skins = %ContainerColumn2.get_children()
	locked_skins.append(%ContainerColumn.get_child(-1))
	var lock_texture = load("res://assets/sprites/lock.png")
	for i in range(0,locked_skins.size()):
		if Constants.SKIN_REQUIREMENTS[i] <= Global.get_high_score(Constants.SKIN_LEVELS[i]):
			locked_skins[i].tooltip_text = ""
		else:
			var texture_rect: TextureRect = TextureRect.new()
			texture_rect.texture = lock_texture
			locked_skins[i].add_child(texture_rect)
			texture_rect.set_anchors_preset(Control.PRESET_CENTER, true)
			texture_rect.scale.x = 2
			texture_rect.scale.y = 2
			texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			locked_skins[i].set_button_disability(true)
			locked_skins[i].tooltip_text = "To unlock get a high score of at least " + str(Constants.SKIN_REQUIREMENTS[i]) + " on level " + str(Constants.SKIN_LEVELS[i].substr(3))
