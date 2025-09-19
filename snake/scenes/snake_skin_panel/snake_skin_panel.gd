extends Control

@export var button_text : String
@export var snake_skin: Texture2D

func _ready() -> void:
	%SnakeSkinDisplayer.snake_skin = snake_skin
	%SnakeSkinDisplayer.draw_after_texture()
	%SkinSelectButton.text = button_text
