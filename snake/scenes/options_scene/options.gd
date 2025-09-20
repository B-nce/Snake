extends Control


signal skin_selected
const volume_offset : float = 0.5

func _ready() -> void:	
	%VolumeSlider.set_value_no_signal(AudioServer.get_bus_volume_db(0)/volume_offset)
	%MuteBox.set_pressed_no_signal(AudioServer.is_bus_mute(0)) 

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_scene/main_menu.tscn")


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
	print("_on_skin_select_button_pressedn")
	skin_selected.emit(snake_path, snake_skin)
	pass
