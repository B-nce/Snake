class_name Apple
extends Area2D

signal apple_eaten

func _ready() -> void:
	connect("area_entered", Callable(self, "_on_area_entered"))

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(Constants.COLLISION_HEAD):
		emit_signal("apple_eaten", self)  
		queue_free()
