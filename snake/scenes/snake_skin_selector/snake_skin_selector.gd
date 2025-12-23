class_name SnakeSkinSelector
extends Control

@export var label_text : String
@export var player_number : int

@onready var skin_index: int = 0


func _ready() -> void:
	%PlayerLabel.text = label_text


func _on_left_button_pressed() -> void:
	skin_index -= 1
	get_dictionary_and_change_skin()


func _on_right_button_pressed() -> void:
	skin_index += 1
	get_dictionary_and_change_skin()


func get_dictionary_and_change_skin() -> void:
	var skin_dict: Dictionary = get_parent().get_parent().get_skin_dictionary()
	if skin_index >= skin_dict.size():
		skin_index = 0
	elif skin_index < 0:
		skin_index = skin_dict.size() - 1
	var skin = skin_dict[skin_index]
	$MainContainer/SnakeSkinPanel.change_skin(skin)


func set_index(index: int) -> void:
	skin_index = index
	get_dictionary_and_change_skin()
