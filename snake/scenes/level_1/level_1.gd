extends Node2D


const AppleScene: PackedScene = preload("res://scenes/apple/apple.tscn")
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var map_size_in_tiles: Vector2 = ($Floor as TileMapLayer).get_used_rect().size


func _ready() -> void:
	_spawn_apple()
	%Player.map_size = self.map_size_in_tiles * Constants.SPRITE_SIZE


func _on_player_apple_eaten() -> void:
	_spawn_apple()


func _on_player_snake_death() -> void:
	var label: Label = Label.new()
	add_child(label)
	label.text = "GAME OVER"
	label.size = Vector2(40,40)


func _spawn_apple() ->void:
	var apple: Node2D = AppleScene.instantiate()
	add_child(apple)
	
	var apple_position: Vector2i = _get_random_position()
	
	while _point_in_area(apple_position):
		apple_position = _get_random_position()
		
	apple.position = apple_position


func _point_in_area(point: Vector2) -> bool:
	var query_parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	query_parameters.collision_mask = Constants.COLLISION_MASK_PLAYER
	query_parameters.collide_with_areas = true
	query_parameters.collide_with_bodies = true
	query_parameters.position = point
	
	var space_state = get_world_2d().direct_space_state
	var result: Array[Dictionary] = space_state.intersect_point(query_parameters, 1)
	return result.size() > 0


func _get_random_position() -> Vector2i:
	return  Vector2i(randi_range(0, map_size_in_tiles.x - 1 ) * Constants.SPRITE_SIZE, 
		randi_range(0, map_size_in_tiles.y - 1) * Constants.SPRITE_SIZE) + Vector2i(Constants.SPRITE_SIZE / 2,Constants.SPRITE_SIZE / 2)
