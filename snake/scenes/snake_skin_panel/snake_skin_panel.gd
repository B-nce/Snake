class_name SnakeSkinPanel
extends Control

signal skin_selected
@export var button_text : String
@export var snake_skin: Texture2D
@export var skin_path: String


func _ready() -> void:
	%SnakeSkinDisplayer.snake_skin = snake_skin
	%SnakeSkinDisplayer.draw_after_texture()
	%SkinSelectButton.text = button_text


func set_button_disability(disabled: bool) -> void:
	%SkinSelectButton.disabled = disabled


func get_button_disability() -> bool:
	return %SkinSelectButton.disabled


func change_skin(new_skin_path: String) -> void:
	%SnakeSkinDisplayer.snake_skin = ResourceLoader.load(new_skin_path) 
	%SnakeSkinDisplayer.draw_after_texture()
	skin_path = new_skin_path
