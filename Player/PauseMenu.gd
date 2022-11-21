# https://www.youtube.com/watch?v=Jf7F3JhY9Fg
extends Control

func _input(event):
	if event.is_action_pressed("pause") and !GlobalFlags.loading:
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		if new_pause_state:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_Resume_pressed():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_Quit_pressed():
	GlobalStats.save_stats()
	get_tree().paused = false
	visible = false
	get_tree().change_scene("res://Main Menu/Main Menu.tscn")

func _on_Reset_pressed():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene("res://Levels/House/House.tscn")
	SpeedrunTimer.time = 0
