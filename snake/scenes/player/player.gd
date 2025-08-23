class_name Player
extends CharacterBody2D


const SnakeSpriteTypes = preload("res://scenes/player/snake_sprite_types.gd")
const BodyPartScene: PackedScene = preload("res://scenes/body_part/body_part.tscn")
@export var direction: float = Constants.ROTATION_UP
@export var health_points: int = 1
@export_range(2, 100, 1) var length: int = 2
@export var texture: Texture2D = load("res://assets/sprites/ball_python.png") 
@export var move_interval: float = 1
var _timer: float = 0
var _previous_tail_position: Vector2

  
func _ready() -> void:
	self.top_level = true
	create_snake_body()


func _process(delta: float) -> void:
	_timer += delta 
	if _timer >= move_interval:
		_move_and_reset_timer()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		if direction == Constants.ROTATION_LEFT or direction == Constants.ROTATION_RIGHT :
			direction = Constants.ROTATION_UP
			_move_and_reset_timer()
	if event.is_action_pressed("down"):
		if direction == Constants.ROTATION_LEFT or direction == Constants.ROTATION_RIGHT :
			direction = Constants.ROTATION_DOWN
			_move_and_reset_timer()
	if event.is_action_pressed("right"):
		if direction == Constants.ROTATION_UP or direction == Constants.ROTATION_DOWN :
			direction = Constants.ROTATION_RIGHT
			_move_and_reset_timer()
	if event.is_action_pressed("left"):
		if direction == Constants.ROTATION_UP or direction == Constants.ROTATION_DOWN :
			direction = Constants.ROTATION_LEFT
			_move_and_reset_timer()


func _add_body_part(part_position: Vector2, type: SnakeSpriteTypes.Type, collision_group: String) -> void:
	var new_part: BodyPart = BodyPartScene.instantiate()
	%BodyParts.add_child(new_part)
	new_part.set_texture(self.texture)
	new_part.set_sprite_type(type)
	new_part.position = part_position
	new_part.add_to_group(collision_group)


func create_snake_body() -> void:
	for i: Node in %BodyParts.get_children():
		%BodyParts.remove_child(i)
		i.queue_free()
		
	var start_positon: Vector2 = position
	for i: int in range(0, length):
		if i == 0 :
			_add_body_part(start_positon, SnakeSpriteTypes.Type.HEAD, Constants.COLLISON_HEAD)
		elif i == length -1 :
			_add_body_part(start_positon, SnakeSpriteTypes.Type.TAIL, Constants.COLLISON_BODY)
		else:
			_add_body_part(start_positon, SnakeSpriteTypes.Type.BODY_STRAIGHT, Constants.COLLISON_BODY)
		start_positon = Vector2(start_positon.x, start_positon.y + Constants.SPRITE_SIZE)


func _move_and_reset_timer() -> void:
	_timer = 0
	_move_snake_body()#first move the snake
	#then add body part
	_check_collision()
	_correct_snake_sprites()#then set new sprite types and rotations


func take_damage() -> void:
	health_points -= 1


func _check_collision() -> void:
	var body_parts: Array[BodyPart] = []
	body_parts.assign(%BodyParts.get_children() as Array[BodyPart])
	
	var overlaps: Array[Area2D] = body_parts[0].get_overlapping_areas()
	if overlaps:
		for overlap: Area2D in overlaps:
			var group: StringName = overlap.get_groups().back()
			match group:
				Constants.COLLISON_BODY:
					take_damage()
				Constants.COLLISON_APPLE:
					_add_body_part(_previous_tail_position, SnakeSpriteTypes.Type.TAIL, Constants.COLLISON_BODY)


func _move_snake_body() -> void:
	var body_parts: Array[BodyPart] = []
	body_parts.assign(%BodyParts.get_children() as Array[BodyPart])
	
	_previous_tail_position = body_parts[-1].position
	
	for i: int in range(body_parts.size() - 1, 0, -1):
		body_parts[i].position = body_parts[i - 1].position
	
	self.position += Vector2(0,-1).rotated(direction) * Constants.SPRITE_SIZE
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
			#flip_horizontally if one of the parts is to the left
			#flip_vertically if one of the parts is to the top
			body_parts[n].flip_horizontally(prev_part_diff.x + Constants.EPSILON < 0 or next_part_diff.x + Constants.EPSILON < 0) 
			body_parts[n].flip_vertically(prev_part_diff.y + Constants.EPSILON < 0 or next_part_diff.y + Constants.EPSILON < 0) 
	
	var tail_difference: Vector2 = body_parts[-2].position - body_parts[-1].position 
	body_parts[-1].update_sprite(tail_difference.angle() + PI/2, SnakeSpriteTypes.Type.TAIL)
