extends Node

var debug = OS.is_debug_build()

var speedrun_mode : bool = false
var loading : bool = false

## GAME VARS ##
var nrg_drank : int = 0
var game_on_hold : bool = false
var game_paid_for : bool = false
var bad_ending : bool = false
var game_grabbed : bool = false
var heart_attack : bool = false
## GAME VARS ##

func debug_screenshot():
	var screenshot = get_viewport().get_texture().get_data()
	screenshot.flip_y()
	screenshot.save_png("res://" + str(OS.get_unix_time()) + ".png")
	print("Saved debug screenshot at res://")

func _input(event):
	if event.is_action_pressed("debug_screenshot") and debug:
		debug_screenshot()
