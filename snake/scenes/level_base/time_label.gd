extends Line2D

func _decrease(point_size) -> void:
	if(points[1].y < points[0].y):
		points[1].y += point_size
	if(points[1].y > points[0].y):
		points[1].y = points[0].y


func _reset() -> void:
	points[1].y = 30
