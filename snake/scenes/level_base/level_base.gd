extends Node2D


const AppleScene: PackedScene = preload("res://scenes/apple/apple.tscn")

@export var level_name: String
 
@onready var high_score = Global.get_high_score(level_name)
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var map_size_in_tiles: Vector2 = ($Floor as TileMapLayer).get_used_rect().size
@onready var wall_tiles: Array[Vector2i] = ($Wall as TileMapLayer).get_used_cells()
@onready var viewport_size: Vector2 = get_viewport().get_visible_rect().size
@onready var new_scale: float = viewport_size.y / (self.map_size_in_tiles.y * Constants.SPRITE_SIZE)
@onready var map_border_size: Vector2 = self.map_size_in_tiles * new_scale * Constants.SPRITE_SIZE
@onready var horizontal_offset: float = (viewport_size.x  / 2) - (map_border_size.x / 2)
@onready var apple_position: Vector2 = $FirstApple.position

var grid: AStarGrid2D
var players: Array[Player] #these can't be @onready because I want them to be typed
var scores: Array[Score]

func _ready() -> void:
	players.assign(get_tree().get_nodes_in_group(Constants.GROUP_PLAYER))
	scores.assign(get_tree().get_nodes_in_group(Constants.GROUP_SCORE))
	$PauseScene.hide()
	_setup_astar()
	_initialize_map_and_players()
	_intialize_scores()
	_reset_scores()


func _on_player_apple_eaten(player: Player) -> void:
	_update_score(player.player_number)
	_spawn_apple()
	_reset_scores()


func _update_score(player_nr: int) -> void:
	for score: Score in scores:
		if score.player_number == player_nr:
			score.update_score()


func _reset_scores() -> void:
	#resets the score timers of alive players
	for score: Score in scores:
		if players.any(func(p: Player): return p == score.player):
			score.restart_score(apple_position)


func _intialize_scores() -> void:	
	var scores_to_delete: Array[Score] 
	for score in scores:
		if score.player.player_number > Global.number_of_players:
			score.queue_free()
			scores_to_delete.append(score)
	for score in scores_to_delete:
		scores.erase(score)
		
	for score: Score in scores:
		score.horizontal_offset = horizontal_offset
		score.grid_scale = self.scale
		score.grid = grid


func _initialize_map_and_players() -> void:
	#make map fill the screen vertically and center horizontally
	self.scale = Vector2(new_scale, new_scale)
	self.position.x += horizontal_offset
	
	var players_to_delete: Array[Player] 
	for player in players:
		if player.player_number > Global.number_of_players:
			player.queue_free()
			players_to_delete.append(player)
	for player in players_to_delete:
		players.erase(player)
	
	for player in players:
		player.map_border = Rect2(Vector2(horizontal_offset, 0), map_border_size)
		player.scale = self.scale		#player needs to be set separately since it's top layer
		player.position *= self.scale
		player.position.x += horizontal_offset
		player.create_snake_body()



func _setup_astar() -> void:
	grid = AStarGrid2D.new()
	grid.region = ($Floor as TileMapLayer).get_used_rect()
	grid.set_diagonal_mode(grid.DIAGONAL_MODE_NEVER)
	grid.update()
	for wall_tile in wall_tiles:
		grid.set_point_solid(wall_tile)
	grid.update()


func _on_player_snake_death(player: Player) -> void:
	players.erase(player)
	player.queue_free()
	if(players.is_empty()):
		var game_over: GameOverScene = load("res://scenes/game_over/game_over.tscn").instantiate()
		get_tree().root.add_child(game_over)
		var high_score_active: bool =  Global.number_of_players == 1 and scores[0].score > high_score
		game_over.set_scores(scores, high_score_active)
		if high_score_active:
			Global.save_high_score(level_name, scores[0].score)


func _spawn_apple() ->void:
	apple_position = _get_random_position()
	
	while await _point_in_area(apple_position):
		apple_position = _get_random_position()
	
	var apple: Node2D = AppleScene.instantiate()
	add_child(apple)
	apple.position = apple_position


func _point_in_area(point: Vector2) -> bool:
	point *= self.scale
	point += horizontal_offset
	var query_parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	query_parameters.collision_mask = Constants.COLLISION_MASK_PLAYER
	query_parameters.collide_with_areas = true
	query_parameters.collide_with_bodies = true
	query_parameters.position = point
	
	var space_state = get_world_2d().direct_space_state
	await get_tree().physics_frame
	var result: Array[Dictionary] = space_state.intersect_point(query_parameters)
	return result.size() > 0


func _get_random_position() -> Vector2i:
	return  Vector2i(randi_range(0, map_size_in_tiles.x - 1 ) * Constants.SPRITE_SIZE, 
		randi_range(0, map_size_in_tiles.y - 1) * Constants.SPRITE_SIZE) + Vector2i(Constants.SPRITE_SIZE / 2,Constants.SPRITE_SIZE / 2)
