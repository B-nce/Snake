extends Node2D


const AppleScene: PackedScene = preload("res://scenes/apple/apple.tscn")
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var map_size_in_tiles: Vector2 = ($Floor as TileMapLayer).get_used_rect().size
@onready var wall_tiles: Array[Vector2i] = ($Wall as TileMapLayer).get_used_cells()
@onready var time_label_size = $TimeLabel.points[0].y - $TimeLabel.points[1].y
var delta_elapsed: float = 0.0
var apple_position: Vector2
var grid: AStarGrid2D


func _ready() -> void:
	_setup_astar()
	_spawn_apple()
	$ScoreTimer.set_wait_time(_calculate_distance(apple_position, %Player.position))
	delta_elapsed = 0.0
	$ScoreTimer.start()
	%Player.map_size = self.map_size_in_tiles * Constants.SPRITE_SIZE


func _process(delta: float) -> void:
	delta_elapsed += delta
	if(delta_elapsed >= 0.1):
		delta_elapsed -= 0.1
		if(!$ScoreTimer.is_stopped()):
			$TimeLabel._decrease(20/$ScoreTimer.wait_time)


func _on_player_apple_eaten() -> void:
	if !$ScoreTimer.is_stopped():
		_update_score(_calculate_score_from_time($ScoreTimer.wait_time, $ScoreTimer.wait_time - $ScoreTimer.time_left))
		$ScoreTimer.stop()
	_spawn_apple()
	$ScoreTimer.set_wait_time(_calculate_distance(apple_position, %Player.position))
	$TimeLabel._reset()
	delta_elapsed = 0.0
	$ScoreTimer.start()


func _calculate_score_from_time(wait_time: int, time_elapsed: float) -> int:
	if time_elapsed < wait_time/4:
		return 3
	else:
		return 2 if time_elapsed < wait_time/2 else 1


func _update_score(score: int) -> void:
	%ScoreLabel.text = str(%ScoreLabel.text.to_int() + score)


func _calculate_distance(a_pos: Vector2, p_pos: Vector2) -> int:
	var a_grid_pos: Vector2 = a_pos/Constants.SPRITE_SIZE
	var p_grid_pos: Vector2 = floor(p_pos/Constants.SPRITE_SIZE)
	var road: Array[Vector2i] = grid.get_id_path(p_grid_pos,a_grid_pos)
	return road.size()-1


func _setup_astar() -> void:
	grid = AStarGrid2D.new()
	grid.region = ($Floor as TileMapLayer).get_used_rect()
	grid.set_diagonal_mode(grid.DIAGONAL_MODE_NEVER)
	grid.update()
	for wall_tile in wall_tiles:
		grid.set_point_solid(wall_tile)
	grid.update()


func _on_player_snake_death() -> void:
	var label: Label = Label.new()
	add_child(label)
	label.text = "GAME OVER"
	label.size = Vector2(40,40)
	$ScoreTimer.stop()


func _spawn_apple() ->void:
	var apple: Apple = AppleScene.instantiate()
	add_child(apple)
	
	apple_position = Vector2(randi_range(0, map_size_in_tiles.x - 1 ) * Constants.SPRITE_SIZE, 
		randi_range(0, map_size_in_tiles.y - 1) * Constants.SPRITE_SIZE)
	
	#apple_pos = apple_position
	while _point_in_area(apple_position):
		apple_position = Vector2(randi_range(0, map_size_in_tiles.x - 1 ) * Constants.SPRITE_SIZE, 
		randi_range(0, map_size_in_tiles.y - 1) * Constants.SPRITE_SIZE)
		
	apple.position = apple_position


func _point_in_area(point: Vector2) -> bool:
	var query_parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	query_parameters.collision_mask = Constants.COLLISION_MASK_PLAYER
	query_parameters.collide_with_areas = true
	query_parameters.collide_with_bodies = false
	query_parameters.position = point
	
	var space_state = get_world_2d().direct_space_state
	var result: Array[Dictionary] = space_state.intersect_point(query_parameters, 1)
	return result.size() > 0
