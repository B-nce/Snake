class_name Apple
extends Area2D


func _ready() -> void:
	add_to_group(Constants.COLLISION_APPLE)
	set_collision_layer_value(Constants.COLLISION_LAYER_PLAYER, true)
	set_collision_mask_value(Constants.COLLISION_MASK_FLOOR, true) 
	set_collision_mask_value(Constants.COLLISION_MASK_PLAYER, true) 
	connect("area_entered", Callable(self, "_on_area_entered"))
