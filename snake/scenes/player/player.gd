class_name Player
extends CharacterBody2D


const SnakeSpriteTypes = preload("res://scenes/player/snake_sprite_types.gd")
@export var direction: float = Constants.ROTATION_UP
@export var health_points: int = 1
@export_range(2, 100, 1) var length: int = 2
@export var texture: Texture2D = load("res://assets/sprites/ball_python.png") 

  
func _ready() -> void:
	self.top_level = true
	create_snake_body()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		if direction == Constants.ROTATION_LEFT or direction == Constants.ROTATION_RIGHT :
			direction = Constants.ROTATION_UP
			move()
	if event.is_action_pressed("down"):
		if direction == Constants.ROTATION_LEFT or direction == Constants.ROTATION_RIGHT :
			direction = Constants.ROTATION_DOWN
			move()
	if event.is_action_pressed("right"):
		if direction == Constants.ROTATION_UP or direction == Constants.ROTATION_DOWN :
			direction = Constants.ROTATION_RIGHT
			move()
	if event.is_action_pressed("left"):
		if direction == Constants.ROTATION_UP or direction == Constants.ROTATION_DOWN :
			direction = Constants.ROTATION_LEFT
			move()


func create_snake_body() -> void:
	for i: Node in %BodyParts.get_children():
		%BodyParts.remove_child(i)
		i.queue_free()
		
	var start_positon: Vector2 = position
	for i: int in range(0, length):
		if i == 0 :
			_add_body_part(start_positon, SnakeSpriteTypes.Type.HEAD, false)
		elif i == length -1 :
			_add_body_part(start_positon, SnakeSpriteTypes.Type.TAIL)
		else:
			_add_body_part(start_positon, SnakeSpriteTypes.Type.BODY_STRAIGHT)
		start_positon = Vector2(start_positon.x, start_positon.y + Constants.SPRITE_SIZE)


func _add_body_part(part_position: Vector2, type: SnakeSpriteTypes.Type, with_collision: bool = true) -> void:
	var new_part: BodyPart = BodyPart.new(texture, part_position, type)
	%BodyParts.add_child(new_part)
	
	if(with_collision):
		var shape: RectangleShape2D = RectangleShape2D.new()
		shape.size = Vector2(Constants.SPRITE_SIZE, Constants.SPRITE_SIZE)
		var collision: CollisionShape2D = CollisionShape2D.new()
		collision.shape = shape
		new_part.add_child(collision)


func move() -> void:
	_move_snake()#first move the snake
	#then add body part
	_correct_snake_sprites()#then set new sprite types and rotations


func _on_timer_timeout() -> void:
	move()


func take_damage() -> void:
	health_points -= 1


var timer: float = 0 
func _process(delta: float) -> void: #temporary func
	timer += delta
	if timer >= 1 :
		move()
		timer = 0

func _move_snake() -> void:
	var movement: Vector2 = Vector2(0,-1).rotated(direction) * Constants.SPRITE_SIZE
	move_and_collide(movement)
	
	var body_parts: Array[BodyPart] = []
	body_parts.assign(%BodyParts.get_children() as Array[BodyPart])
		
	for i: int in range(body_parts.size() - 1, 0, -1):
		body_parts[i].position = body_parts[i - 1].position
	
	body_parts[0].position = self.position


func _correct_snake_sprites() -> void:
	var body_parts: Array[BodyPart] = []
	body_parts.assign(%BodyParts.get_children() as Array[BodyPart])
	
	body_parts[0].update_sprite(direction, SnakeSpriteTypes.Type.HEAD)
	
	for n: int in range(1,body_parts.size() - 1):
		var next_part_diff: Vector2 = body_parts[n + 1].position - body_parts[n].position
		var prev_part_diff: Vector2 = body_parts[n - 1].position - body_parts[n].position
		var difference: Vector2 = body_parts[n - 1].position - body_parts[n + 1].position 
		if abs(difference.x) < Constants.EPSILON or abs(difference.y) < Constants.EPSILON:
			body_parts[n].update_sprite(prev_part_diff.angle() + PI/2, SnakeSpriteTypes.Type.BODY_STRAIGHT)
		else:
			body_parts[n].update_sprite(0, SnakeSpriteTypes.Type.BODY_TURN)
			#flip_h if one of the parts is to the left
			#flip_v if one of the parts is to the top
			body_parts[n].flip_h = prev_part_diff.x + Constants.EPSILON < 0 or next_part_diff.x + Constants.EPSILON < 0
			body_parts[n].flip_v = prev_part_diff.y + Constants.EPSILON < 0 or next_part_diff.y + Constants.EPSILON < 0
	
	var tail_difference: Vector2 = body_parts[-2].position - body_parts[-1].position 
	body_parts[-1].update_sprite(tail_difference.angle() + PI/2, SnakeSpriteTypes.Type.TAIL)
