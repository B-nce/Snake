extends Control


func _input(event: InputEvent) -> void:
	if get_node("/root").get_node("GameOver"):
		return
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			self.hide()
			get_tree().paused = false
		else:
			self.show()
			get_tree().paused = true


func _on_continue_button_pressed() -> void:
	if get_tree().paused:
		get_tree().paused = false
		self.hide()


func _on_back_button_pressed() -> void:
	if get_tree().paused:
		get_tree().paused = false
	self.queue_free()
	get_tree().change_scene_to_file(Global.previous_scene_paths.pop_front()) 
