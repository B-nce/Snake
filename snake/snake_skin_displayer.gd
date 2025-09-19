extends Control

const SnakeSpriteTypes = preload("res://scenes/player/snake_sprite_types.gd")
var snake_skin: Texture2D 

func draw_after_texture() -> void:
	%SnakeHead.snake_skin.atlas = snake_skin
	%SnakeHead.snake_skin.region = set_sprite_type(SnakeSpriteTypes.Type.HEAD)
	%SnakeTurn.snake_skin.atlas = snake_skin
	%SnakeTurn.snake_skin.region = set_sprite_type(SnakeSpriteTypes.Type.BODY_TURN)
	%SnakeTail.snake_skin.atlas = snake_skin
	%SnakeTail.snake_skin.region = set_sprite_type(SnakeSpriteTypes.Type.TAIL)
	%SnakeStraight.snake_skin.atlas = snake_skin
	%SnakeStraight.snake_skin.region = set_sprite_type(SnakeSpriteTypes.Type.BODY_STRAIGHT)
	pass


func set_sprite_type(type: SnakeSpriteTypes.Type) -> Rect2:
	var top_left_x: float = Constants.SPRITE_SIZE * type
	var top_left_y: float = 0
	var width: float = Constants.SPRITE_SIZE
	var height: float = Constants.SPRITE_SIZE
	return Rect2(top_left_x, top_left_y, width, height)
