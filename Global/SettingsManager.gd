extends Node

var SETTINGS_PATH = "user://settings.cfg"

var settings_loaded = false

### Settings ###
# Video Settings
var fullscreen : bool = true
var vsync_enabled : bool = true
# Audio Settings
var master_volume : float = 0
var music_volume : float = 0
var sfx_volume : float = 0
# Game Settings
var camera_fov : int = 70
var mouse_sensitivity : float = 0.2
var head_bobbing : bool = true
var speedrun_mode : bool = false
var skip_tutorial : bool = false
var use_key = 0
### End Settings ###

func _init():
	# If it's a debug build, then place the settings file next to the executable (or in the project folder) rather than the user folder
	if OS.is_debug_build():
		SETTINGS_PATH = "res://settings.cfg"

func save_settings():
	# Create the config file
	var config = ConfigFile.new()
	
	# Save the value of the settings variables (see line 8) to the settings config
	config.set_value("settings", "fullscreen", fullscreen)
	config.set_value("settings", "vsync_enabled", vsync_enabled)
	config.set_value("settings", "master_volume", master_volume)
	config.set_value("settings", "music_volume", music_volume)
	config.set_value("settings", "sfx_volume", sfx_volume)
	config.set_value("settings", "camera_fov", camera_fov)
	config.set_value("settings", "mouse_sensitivity", mouse_sensitivity)
	config.set_value("settings", "head_bobbing", head_bobbing)
	config.set_value("settings", "speedrun_mode", speedrun_mode)
	config.set_value("settings", "skip_tutorial", skip_tutorial)
	config.set_value("settings", "use_key", use_key)
	
	# Then write the settings variables to the config file
	config.save(SETTINGS_PATH)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_PATH)
	
	if err == OK:
		fullscreen = config.get_value("settings", "fullscreen")
		vsync_enabled = config.get_value("settings", "vsync_enabled")
		master_volume = db2linear(config.get_value("settings", "master_volume"))
		music_volume = db2linear(config.get_value("settings", "music_volume"))
		sfx_volume = db2linear(config.get_value("settings", "sfx_volume"))
		camera_fov = config.get_value("settings", "camera_fov")
		mouse_sensitivity = config.get_value("settings", "mouse_sensitivity")
		head_bobbing = config.get_value("settings", "head_bobbing")
		speedrun_mode = config.get_value("settings", "speedrun_mode")
		skip_tutorial = config.get_value("settings", "skip_tutorial")
		use_key = config.get_value("settings", "skip_tutorial")
		
		settings_loaded = true
	
	return err

func default_settings():
	# Sets the settings variables to their default values, it's the same as above in the source code
	fullscreen = true
	vsync_enabled = true
	master_volume = 0
	music_volume = 0
	sfx_volume = 0
	camera_fov = 70
	mouse_sensitivity = 0.2
	head_bobbing = true
	speedrun_mode = false
	skip_tutorial = false
	use_key = 0
	
	# Then it saves the settings, just in case
	save_settings()
