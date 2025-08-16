class_name BodyPart
extends Sprite2D

const SnakeSpriteTypes = preload("res://scenes/player/snake_sprite_types.gd")
@export var sprite_path : String 

func _init(file_path: String, intial_position: Vector2, type: SnakeSpriteTypes.Type) -> void:
	self.region_enabled = true 
	self.sprite_path = file_path
	self.texture = load(file_path)
	self._set_sprite_type(type)
	self.position = intial_position


func update_sprite(new_position: Vector2, new_rotation: float, type: SnakeSpriteTypes.Type) -> void:
	_set_sprite_type(type)
	self.position = new_position
	self.rotation = new_rotation


func _set_sprite_type(type: SnakeSpriteTypes.Type) -> void:
	var top_left_x: float = Constants.SPRITE_SIZE * type
	var top_left_y: float = 0
	var width: float = Constants.SPRITE_SIZE
	var height: float = Constants.SPRITE_SIZE
	self.region_rect = Rect2(top_left_x, top_left_y, width, height)
