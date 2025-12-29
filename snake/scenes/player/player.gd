class_name Player
extends CharacterBody2D

signal snake_death
signal apple_eaten

enum DirectionEnum {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

const SnakeSpriteTypes = preload("res://scenes/player/snake_sprite_types.gd")
const BodyPartScene: PackedScene = preload("res://scenes/body_part/body_part.tscn")

@export var health_points: int = 1
@export var despawn_after_seconds: float = 5
@export_range(2, 100, 1) var length: int = 2 
@export var move_interval: float = 1
@export var movement_is_enabled: bool = true
@export var map_border: Rect2 = Rect2(Vector2(0,0), Vector2(18,20))
@export var player_number: int = 1
@export var initial_direction: DirectionEnum = DirectionEnum.UP

var _timer: float = 0
var _previous_tail_position: Vector2

@onready var rotation_value: float = _get_rotation_from_initial_direction()
@onready var texture: Texture2D = load(Global.get_selected_skin(player_number))


func _ready() -> void:
	self.top_level = true
	$PlayerNumber.text = str(player_number)

func set_snake_skin(new_texture: Texture2D) -> void:
	self.texture = new_texture
	create_snake_body()


func _physics_process(delta: float) -> void:
	_timer += delta 
	if _timer >= move_interval :
		_move_and_reset_timer()


func _input(event: InputEvent) -> void:
	if movement_is_enabled:
		if event.is_action_pressed("up_" + str(player_number)):
			if rotation_value == Constants.ROTATION_LEFT or rotation_value == Constants.ROTATION_RIGHT :
				rotation_value = Constants.ROTATION_UP
				_move_and_reset_timer()
		if event.is_action_pressed("down_" + str(player_number)):
			if rotation_value == Constants.ROTATION_LEFT or rotation_value == Constants.ROTATION_RIGHT :
				rotation_value = Constants.ROTATION_DOWN
				_move_and_reset_timer()
		if event.is_action_pressed("right_" + str(player_number)):
			if rotation_value == Constants.ROTATION_UP or rotation_value == Constants.ROTATION_DOWN :
				rotation_value = Constants.ROTATION_RIGHT
				_move_and_reset_timer()
		if event.is_action_pressed("left_" + str(player_number)):
			if rotation_value == Constants.ROTATION_UP or rotation_value == Constants.ROTATION_DOWN :
				rotation_value = Constants.ROTATION_LEFT
				_move_and_reset_timer()


func _add_body_part(part_position: Vector2, type: SnakeSpriteTypes.Type, collision_group: String) -> BodyPart:
	var new_part: BodyPart = BodyPartScene.instantiate()
	%BodyParts.add_child(new_part)
	new_part.set_texture(self.texture)
	new_part.set_sprite_type(type)
	new_part.position = part_position
	new_part.add_to_group(collision_group)
	new_part.scale = self.scale
	new_part.rotate_sprite(rotation_value)
	return new_part


func create_snake_body() -> void:
	for i: Node in %BodyParts.get_children():
		%BodyParts.remove_child(i)
		i.queue_free()
		
	var part_positon: Vector2 = position
	for i: int in range(0, length):
		if i == 0 :
			var head: BodyPart = _add_body_part(part_positon, SnakeSpriteTypes.Type.HEAD, Constants.GROUP_HEAD)
			head.connect("area_entered", _on_head_collision)
			head.connect("body_entered", _on_head_collision)
			head.monitoring = true
		elif i == length -1 :
			_add_body_part(part_positon, SnakeSpriteTypes.Type.TAIL, Constants.GROUP_BODY)
		else:
			_add_body_part(part_positon, SnakeSpriteTypes.Type.BODY_STRAIGHT, Constants.GROUP_BODY)
		part_positon = _get_next_position_based_on_direction(part_positon)


func _get_next_position_based_on_direction(pos: Vector2) -> Vector2:
	var new_pos: Vector2
	match initial_direction:
		DirectionEnum.UP:
			new_pos =  Vector2(pos.x, pos.y + Constants.SPRITE_SIZE * self.scale.y)
		DirectionEnum.DOWN:
			new_pos = Vector2(pos.x, pos.y - Constants.SPRITE_SIZE * self.scale.y)
		DirectionEnum.LEFT:
			new_pos = Vector2(pos.x + Constants.SPRITE_SIZE * self.scale.x, pos.y)
		DirectionEnum.RIGHT:
			new_pos = Vector2(pos.x - Constants.SPRITE_SIZE * self.scale.x, pos.y)
	return new_pos

func _get_rotation_from_initial_direction() -> float:
	var return_value: float
	match initial_direction:
		DirectionEnum.UP:
			return_value =  Constants.ROTATION_UP
		DirectionEnum.DOWN:
			return_value =  Constants.ROTATION_DOWN
		DirectionEnum.LEFT:
			return_value =  Constants.ROTATION_LEFT
		DirectionEnum.RIGHT:
			return_value =  Constants.ROTATION_RIGHT
	return return_value


func _on_head_collision(overlap: Node2D) -> void:
	var group: StringName = overlap.get_groups().back()
	match group:
		Constants.GROUP_BODY, Constants.GROUP_WALL, Constants.GROUP_HEAD:
			_take_damage()
		Constants.GROUP_APPLE:
			_eat_apple(overlap)


func _move_and_reset_timer() -> void:
	_timer = 0
	if movement_is_enabled :
		_move_snake_body()
		_correct_snake_sprites()


func _take_damage() -> void:
	health_points -= 1
	if health_points <= 0:
		%Stars.visible = true
		%Stars.play_animation()
		movement_is_enabled = false
		$DeathTimer.start(despawn_after_seconds)


func _on_death_timer_timeout() -> void:
	snake_death.emit(self)


func _eat_apple(apple: Node2D) -> void:
	apple.queue_free()
	_add_body_part(_previous_tail_position, SnakeSpriteTypes.Type.TAIL, Constants.GROUP_BODY)
	_correct_snake_sprites()
	apple_eaten.emit(self)


func _move_snake_body() -> void:
	var body_parts: Array[BodyPart] = []
	body_parts.assign(%BodyParts.get_children() as Array[BodyPart])
	
	_previous_tail_position = body_parts[-1].position
	
	for i: int in range(body_parts.size() - 1, 0, -1):
		body_parts[i].position = body_parts[i - 1].position
	
	self.position += Vector2(0,-1).rotated(rotation_value) * Constants.SPRITE_SIZE * self.scale
	#The snake comes back on the other side of the map
	
	self.position.x = roundi(map_border.position.x + fposmod(self.position.x - map_border.position.x, map_border.size.x))
	self.position.y = roundi(map_border.position.y + fposmod(self.position.y - map_border.position.y, map_border.size.y))
	
	body_parts[0].position = self.position


func _correct_snake_sprites() -> void:
	var body_parts: Array[BodyPart] = []
	body_parts.assign(%BodyParts.get_children() as Array[BodyPart])
	
	body_parts[0].update_sprite(rotation_value, SnakeSpriteTypes.Type.HEAD)
	
	for n: int in range(1,body_parts.size() - 1):
		var next_part_diff: Vector2 = _wrap_diff(body_parts[n + 1].position - body_parts[n].position)
		var prev_part_diff: Vector2 =_wrap_diff(body_parts[n - 1].position - body_parts[n].position)

		var difference: Vector2 = body_parts[n - 1].position - body_parts[n + 1].position 
		if abs(difference.x) < Constants.EPSILON or abs(difference.y) < Constants.EPSILON:
			body_parts[n].update_sprite(prev_part_diff.angle() + PI/2, SnakeSpriteTypes.Type.BODY_STRAIGHT)
		else:
			body_parts[n].update_sprite(0, SnakeSpriteTypes.Type.BODY_TURN)
			#flip_horizontally if one of the parts is to the left
			#flip_vertically if one of the parts is to the top
			body_parts[n].flip_horizontally(prev_part_diff.x + Constants.EPSILON < 0 or next_part_diff.x + Constants.EPSILON < 0) 
			body_parts[n].flip_vertically(prev_part_diff.y + Constants.EPSILON < 0 or next_part_diff.y + Constants.EPSILON < 0) 
	
	var tail_difference: Vector2 = _wrap_diff(body_parts[-2].position - body_parts[-1].position) 
	body_parts[-1].update_sprite(tail_difference.angle() + PI/2, SnakeSpriteTypes.Type.TAIL)


#If the next or previous part is not next to the current part it means the snake is
#wrapping around the map. In that case the prev or next part is in the opposite direction
func _wrap_diff(diff: Vector2) -> Vector2:
	return diff if abs(diff.x) <= (Constants.SPRITE_SIZE * self.scale.x) and abs(diff.y) <= (Constants.SPRITE_SIZE * self.scale.y) else -diff
