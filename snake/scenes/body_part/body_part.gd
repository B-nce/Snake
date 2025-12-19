class_name BodyPart
extends Area2D

const SnakeSpriteTypes = preload("res://scenes/player/snake_sprite_types.gd")
@onready var sprite: Sprite2D = %Sprite2D
@onready var collision_shape: CollisionShape2D = %CollisionShape2D as CollisionShape2D
@onready var rect_shape: RectangleShape2D = collision_shape.shape as RectangleShape2D

func _ready() -> void:
	sprite.region_enabled = true 
	rect_shape.size = Vector2(Constants.SPRITE_SIZE - 2, Constants.SPRITE_SIZE - 2)
	self.top_level = true


func set_texture(sprite_texture: Texture2D) -> void:
	sprite.texture = sprite_texture


func update_sprite(new_rotation: float, type: SnakeSpriteTypes.Type) -> void:
	set_sprite_type(type)
	rotate_sprite(new_rotation)


func rotate_sprite(new_rotation: float) -> void:
	sprite.rotation = new_rotation


func set_sprite_type(type: SnakeSpriteTypes.Type) -> void:
	var top_left_x: float = Constants.SPRITE_SIZE * type
	var top_left_y: float = 0
	var width: float = Constants.SPRITE_SIZE
	var height: float = Constants.SPRITE_SIZE
	sprite.region_rect = Rect2(top_left_x, top_left_y, width, height)


func flip_horizontally(value: bool) -> void:
	sprite.flip_h = value


func flip_vertically(value: bool) -> void:
	sprite.flip_v = value
