class_name WallTileLayer
extends TileMapLayer


func _ready() -> void:
	var used_cells: Array[Vector2i] = self.get_used_cells()
	for cell: Vector2i in used_cells:

		var world_pos: Vector2 = map_to_local(cell)
		var area: Area2D = Area2D.new()
		self.add_child(area)

		area.position = world_pos

		var collision_shape: CollisionShape2D  = CollisionShape2D.new()
		area.add_child(collision_shape)
		area.set_collision_layer_value(Constants.COLLISION_LAYER_PLAYER, true)
		area.set_collision_mask_value(Constants.COLLISION_MASK_FLOOR, true) 
		area.set_collision_mask_value(Constants.COLLISION_MASK_PLAYER, true)  
		area.add_to_group(Constants.COLLISION_WALL)
		
		var rect_shape: RectangleShape2D = RectangleShape2D.new()
		rect_shape.extents = Vector2(tile_set.tile_size.x / 2.0, tile_set.tile_size.y / 2.0)
		collision_shape.shape = rect_shape
