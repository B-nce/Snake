extends Node2D


func _ready() -> void:
	var player: Player = $Player as Player
	player.create_snake_body()
