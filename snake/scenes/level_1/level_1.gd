extends Node2D


const Apple = preload("res://scenes/apple/apple.tscn")
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var map_size: Vector2 = $Floor.get_used_rect().size * Constants.SPRITE_SIZE

func _ready() -> void:
	_spawn_apple()
	%Player.map_size = self.map_size


func _on_apple_eaten(apple) -> void:
	_spawn_apple()


func _on_player_snake_death() -> void:
	var label: Label = Label.new()
	add_child(label)
	label.text = "GAME OVER"
	label.size = Vector2(40,40)


func _spawn_apple():
	var apple: Apple = Apple.instantiate()
	add_child(apple)
	apple.connect("apple_eaten", Callable(self, "_on_apple_eaten"))

	var apple_position: Vector2 = Vector2(randi_range(0, map_size.x) / Constants.SPRITE_SIZE, 
		randi_range(0, map_size.y) / Constants.SPRITE_SIZE)
		
	while _point_in_area(apple_position):
		apple_position = Vector2(randi_range(0, map_size.x - 1) / Constants.SPRITE_SIZE, 
		randi_range(0, map_size.y - 1) / Constants.SPRITE_SIZE)
		
	apple.position = apple_position


func _point_in_area(point: Vector2) -> bool:
	var query_parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	query_parameters.collision_mask = Constants.COLLISION_MASK_PLAYER
	query_parameters.collide_with_areas = true
	query_parameters.collide_with_bodies = false
	query_parameters.position = point
	
	var space_state = get_world_2d().direct_space_state
	var result: Array[Dictionary] = space_state.intersect_point(query_parameters)
	return result.size() > 0
