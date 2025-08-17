class_name Player
extends CharacterBody2D


const SnakeSpriteTypes = preload("res://scenes/player/snake_sprite_types.gd")
@export var direction: float = Constants.ROTATION_UP
@export var health_points: int = 1
@export var sprite_file_path: String

  
func initialize(snake_sprite_path: String) -> void:
	self.sprite_file_path = snake_sprite_path
	var tail_postion: Vector2 = Vector2(position.x, position.y + Constants.SPRITE_SIZE)
	_add_body_part(position, SnakeSpriteTypes.Type.HEAD, false)
	_add_body_part(tail_postion, SnakeSpriteTypes.Type.TAIL)


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


func _add_body_part(part_position: Vector2, type: SnakeSpriteTypes.Type, with_collision: bool = true) -> void:
	var new_part: BodyPart = BodyPart.new(sprite_file_path, part_position, type)
	$BodyParts.add_child(new_part)
	
	if(with_collision):
		var shape: RectangleShape2D = RectangleShape2D.new()
		shape.size = Vector2(Constants.SPRITE_SIZE, Constants.SPRITE_SIZE)
		var collision: CollisionShape2D = CollisionShape2D.new()
		collision.shape = shape
		new_part.add_child(collision)


func move() -> void:
	#first move the snake
	#then add body part
	#then set new sprite types and rotations
	move_and_slide()
	

func _on_timer_timeout() -> void:
	move()
	
func take_damage() -> void:
	health_points -= 1
