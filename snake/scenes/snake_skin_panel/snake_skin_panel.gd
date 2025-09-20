extends Control

signal skin_selected
@export var button_text : String
@export var snake_skin: Texture2D
@export var skin_path: String

func _ready() -> void:
	%SnakeSkinDisplayer.snake_skin = snake_skin
	%SnakeSkinDisplayer.draw_after_texture()
	%SkinSelectButton.text = button_text


func _on_skin_select_button_pressed() -> void:
	skin_selected.emit(skin_path, snake_skin)
