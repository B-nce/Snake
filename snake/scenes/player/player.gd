extends CharacterBody2D

var direction = Vector2(0, -1)
var rot = 0
var health_points = 1
var score = 0

func _input(event):
	if event.is_action_pressed("up"):
		if direction != Vector2(0,1)&& direction != Vector2(0,-1):
			direction = Vector2(0,-1)
			%BallPythonHead.rotation_degrees = 0
			move()
			%MoveTimer.start()
	if event.is_action_pressed("down"):
		if direction != Vector2(0,-1) && direction != Vector2(0,1):
			direction = Vector2(0,1)
			%BallPythonHead.rotation_degrees = 180
			move()
			%MoveTimer.start()
	if event.is_action_pressed("right"):
		if direction != Vector2(-1,0)&& direction != Vector2(1,0):
			direction = Vector2(1,0)
			%BallPythonHead.rotation_degrees = 90
			move()
			%MoveTimer.start()
	if event.is_action_pressed("left")&& direction != Vector2(-1,0):
		if direction != Vector2(1,0):
			direction = Vector2(-1,0)
			%BallPythonHead.rotation_degrees = 270
			move()
			%MoveTimer.start()

func move() -> void:
	global_position += direction * 16
	#rotation_degrees = rot
	move_and_slide()
	

func _on_timer_timeout() -> void:
	move()
	
func take_damage() -> void:
	health_points -= 1
