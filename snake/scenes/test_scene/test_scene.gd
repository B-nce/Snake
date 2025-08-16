extends Node2D


func  _ready() -> void:
	var player: Player = $Player
	player.initialize("res://assets/sprites/ball_python.png")
	
