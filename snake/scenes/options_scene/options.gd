extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_scene/main_menu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value*0.5)


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0,false)
