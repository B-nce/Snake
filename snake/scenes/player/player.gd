class_name Player
extends CharacterBody2D


const SnakeSpriteTypes = preload("res://scenes/player/snake_sprite_types.gd")
@export var direction: float = Constants.ROTATION_UP
@export var health_points: int = 1
@export var sprite_file_path: String
var _body_parts: Array[BodyPart] = []

  
func initialize(snake_sprite_path: String) -> void:
	self.sprite_file_path = snake_sprite_path
	
	var tail_postion: Vector2 = Vector2(position.x, position.y + Constants.SPRITE_SIZE)
	var head: BodyPart = BodyPart.new(snake_sprite_path, position, SnakeSpriteTypes.Type.HEAD)
	var tail: BodyPart = BodyPart.new(snake_sprite_path, tail_postion, SnakeSpriteTypes.Type.TAIL)
	self.add_child(head)
	self.add_child(tail) #TODO invent something better
	self._body_parts.append(head)
	self._body_parts.append(tail)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		if(direction == Constants.ROTATION_LEFT or direction == Constants.ROTATION_RIGHT):
			direction = Constants.ROTATION_UP
			move()
	if event.is_action_pressed("down"):
		if(direction == Constants.ROTATION_LEFT or direction == Constants.ROTATION_RIGHT):
			direction = Constants.ROTATION_DOWN
			move()
	if event.is_action_pressed("right"):
		if(direction == Constants.ROTATION_UP or direction == Constants.ROTATION_DOWN):
			direction = Constants.ROTATION_RIGHT
			move()
	if event.is_action_pressed("left"):
		if(direction == Constants.ROTATION_UP or direction == Constants.ROTATION_DOWN):
			direction = Constants.ROTATION_LEFT
			move()



func move() -> void:
	#rotation_degrees = rot
	move_and_slide()
	

func _on_timer_timeout() -> void:
	move()
	
func take_damage() -> void:
	health_points -= 1
