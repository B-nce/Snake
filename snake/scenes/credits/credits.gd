extends Control


var in_time : float = 0.5
var fade_in_time : float = 1.0
var pause_time : float = 4.5
var fade_out_time : float = 1.0
var out_time : float = 0.5
var splash_screen : VBoxContainer

func _ready() -> void:
	splash_screen = $VBoxContainer
	fade()

func fade() -> void:
	splash_screen.modulate.a = 0.0
	var tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(splash_screen, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(splash_screen, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	await tween.finished
	get_tree().change_scene_to_file(Global.previous_scene_paths.pop_front()) 
