extends Control


func _on_new_game_pressed() -> void:
	pass # Replace with function body.


func _on_level_select_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_scene/options.tscn")


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
