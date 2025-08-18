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
	#move()
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
	%BodyParts.add_child(new_part)
	
	if(with_collision):
		var shape: RectangleShape2D = RectangleShape2D.new()
		shape.size = Vector2(Constants.SPRITE_SIZE, Constants.SPRITE_SIZE)
		var collision: CollisionShape2D = CollisionShape2D.new()
		collision.shape = shape
		new_part.add_child(collision)


func move() -> void:
	move_snake()#first move the snake
	#then add body part
	correct_snake_sprites()#then set new sprite types and rotations
	

func _on_timer_timeout() -> void:
	move()
	
func take_damage() -> void:
	health_points -= 1
	
	
func move_snake() -> void:
	var head: Sprite2D = %BodyParts.get_child(0)
	var prev_position: Vector2 = head.position
	var temp_position: Vector2 = head.position
	head.position += Vector2(0,-1).rotated(direction) * Constants.SPRITE_SIZE
	var body_part_array: Array[Node] = %BodyParts.get_children()
	body_part_array.remove_at(0)
	for body_part: Sprite2D in body_part_array:
		temp_position = body_part.position
		body_part.position = prev_position
		prev_position = temp_position


func add_snake_part() -> void:
	pass#TODO


func correct_snake_sprites() -> void:
	var head: Sprite2D = %BodyParts.get_child(0)
	var prev_position: Vector2 = head.position
	var temp_position: Vector2 = head.position
	head.rotation = 0
	head.rotate(direction)
	var body_part_array: Array[Node] = %BodyParts.get_children()
	body_part_array.remove_at(0)
	
	var tail: Sprite2D = body_part_array.pop_at(-1)
	tail._set_sprite_type(SnakeSpriteTypes.Type.TAIL)
	var new_direction: Vector2
	if body_part_array.is_empty():
		new_direction =  head.position - tail.position
	else:
		new_direction = body_part_array[-1].position - tail.position
	tail.rotation = 0
	tail.rotate(new_direction.angle() + PI/2)
	
	body_part_array = %BodyParts.get_children()
	for n in range(1,body_part_array.size() - 1):
		if (body_part_array[n - 1].position - body_part_array[n + 1].position).x == 0 or (body_part_array[n - 1].position - body_part_array[n + 1].position).y == 0:
			body_part_array[n]._set_sprite_type(SnakeSpriteTypes.Type.BODY_STRAIGHT)
			new_direction = body_part_array[n - 1].position - body_part_array[n].position
			body_part_array[n].rotation = 0
			body_part_array[n].rotate(new_direction.angle() + PI/2)
		else:
			#TODO needs mirroring in certain scenarios, also needs testing
			body_part_array[n]._set_sprite_type(SnakeSpriteTypes.Type.BODY_TURN)
			new_direction = body_part_array[n - 1].position - body_part_array[n].position
			body_part_array[n].rotation = 0
			body_part_array[n].rotate(new_direction.angle() + PI)
