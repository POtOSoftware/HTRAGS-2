extends Control

var STATS_LOCATION = "user://player.stats"
var directory = Directory.new()

func _init():
	SpeedrunTimer.time = 0
	if not OS.get_name() == "HTML5":
		SettingsManager.load_settings()
	GlobalStats.load_stats()

func _ready():
	if GlobalFlags.debug:
		STATS_LOCATION = "res://player.stats"
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if OS.get_name() == "HTML5":
		$"Title Screen Layer/Title Screen/VBoxContainer/Quit".visible = false
	#$"Title Screen Layer/Title Screen/VBoxContainer/Start".grab_focus()

func _on_Start_pressed():
	if SettingsManager.skip_tutorial:
		LevelManager.load_level("House/House.tscn")
	else:
		LevelManager.load_level("Tutorial/Tutorial.tscn")
	$"Title Screen Layer".layer = -2

func _on_Quit_pressed():
	$"Title Screen Layer/Title Screen/VBoxContainer/Quit/ConfirmationDialog".popup()
	GlobalStats.save_stats()

func _on_Settings_pressed():
	# Because of the canvas layer, I have to hide each button individually for some reason
	$"Title Screen Layer/Title Screen".visible = false
	
	$SettingsLayer/Settings.visible = true

func _on_Back_pressed():
	# Save the settings when the player presses the back button
	SettingsManager.save_settings()
	$SettingsLayer/Settings.update_settings()
	# Then show the title screen, and hide the settings screen
	$"Title Screen Layer/Title Screen".visible = true
	
	$SettingsLayer/Settings.visible = false

func _on_Credits_pressed():
	get_tree().change_scene("res://Main Menu/Credits/Credits.tscn")
