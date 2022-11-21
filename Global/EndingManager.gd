extends Node

var ending_quote : String

func end_game(end_quote : String="i forgor"):
	SpeedrunTimer.timer_on = false
	GlobalStats.times_completed += 1
	ending_quote = end_quote
	get_tree().change_scene("res://Ending Screen/Ending Screen.tscn")

func screenshot():
	var screenshot = get_viewport().get_texture().get_data()
	screenshot.flip_y()
	screenshot.save_png("user://screenshot.png")
	return screenshot
