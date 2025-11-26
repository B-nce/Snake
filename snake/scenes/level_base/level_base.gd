extends Node2D


const AppleScene: PackedScene = preload("res://scenes/apple/apple.tscn")
@export var level_name: String
@onready var high_score = Global.get_high_score(level_name)
@onready var high_score_label: Label = %HighScoreLabel as Label
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var map_size_in_tiles: Vector2 = ($Floor as TileMapLayer).get_used_rect().size
@onready var wall_tiles: Array[Vector2i] = ($Wall as TileMapLayer).get_used_cells()
@onready var time_label_size = $TimeLabel.points[0].y - $TimeLabel.points[1].y
@onready var viewport_size: Vector2 = get_viewport().get_visible_rect().size
@onready var new_scale: float = viewport_size.y / (self.map_size_in_tiles.y * Constants.SPRITE_SIZE)
@onready var map_border_size: Vector2 = self.map_size_in_tiles * new_scale * Constants.SPRITE_SIZE
@onready var horizontal_offset: float = (viewport_size.x  / 2) - (map_border_size.x / 2)
var delta_elapsed: float = 0.0
@onready var player: Player = %Player as Player
@onready var score: int = 0
var apple_position: Vector2
var grid: AStarGrid2D


func _ready() -> void:
	_setup_astar()
	_spawn_apple()
	_initialize_map_and_player()
	$ScoreTimer.set_wait_time(_calculate_distance(apple_position, player.position))
	delta_elapsed = 0.0
	$ScoreTimer.start()
	high_score_label.text = str(high_score)

func _process(delta: float) -> void:
	delta_elapsed += delta
	if(delta_elapsed >= 0.1):
		delta_elapsed -= 0.1
		if(!$ScoreTimer.is_stopped()):
			$TimeLabel._decrease(20/$ScoreTimer.wait_time)

func _on_player_apple_eaten() -> void:
	if !$ScoreTimer.is_stopped():
		var time_elapsed = $ScoreTimer.wait_time - $ScoreTimer.time_left
		$ScoreTimer.stop()
		score += _calculate_score_from_time($ScoreTimer.wait_time, time_elapsed)
		_update_score(score)
	_spawn_apple()
	$ScoreTimer.set_wait_time(_calculate_distance(apple_position, player.position))
	$TimeLabel._reset()
	delta_elapsed = 0.0
	$ScoreTimer.start()


func _initialize_map_and_player() -> void:
	#make map fill the screen vertically and center horizontally
	self.scale = Vector2(new_scale, new_scale)
	self.position.x += horizontal_offset
	#player needs to be set separately since it's top layer
	player.map_border = Rect2(Vector2(horizontal_offset, 0), map_border_size)
	player.scale = self.scale
	player.position *= self.scale
	player.position.x += horizontal_offset
	player.create_snake_body()


func _calculate_score_from_time(wait_time: int, time_elapsed: float) -> int:
	if time_elapsed < wait_time/4:
		return 3
	else:
		return 2 if time_elapsed < wait_time/2 else 1


func _update_score(score: int) -> void:
	%ScoreLabel.text = str(score)


func _calculate_distance(a_pos: Vector2, p_pos: Vector2) -> int:
	p_pos.x -= horizontal_offset
	var a_grid_pos: Vector2 = floor(a_pos/(Constants.SPRITE_SIZE))
	var p_grid_pos: Vector2 = floor(p_pos/(Constants.SPRITE_SIZE*self.scale))
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
	if score > high_score:
		Global.save_high_score(level_name, score)
	var game_over: GameOverScene = load("res://scenes/game_over/game_over.tscn").instantiate()
	get_tree().root.add_child(game_over)
	game_over.set_score(%ScoreLabel.text, score > high_score)



func _spawn_apple() ->void:
	var apple: Node2D = AppleScene.instantiate()
	add_child(apple)

	apple_position = _get_random_position()
	
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
