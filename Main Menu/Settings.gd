extends Control

onready var fov_text = $"TabContainer/Game/FOV"
onready var fov_slider = $TabContainer/Game/FOVSlider

# I'm not writing any meaningful comments for this, you can figure it out
func update_settings():
	$TabContainer/Video/Fullscreen.pressed = SettingsManager.fullscreen
	$TabContainer/Video/Vsync.pressed = SettingsManager.vsync_enabled
	# I forgor to give the volume sliders actual names, oops
	$TabContainer/Audio/VolumeSlider3.value = db2linear(SettingsManager.sfx_volume)
	$TabContainer/Audio/VolumeSlider2.value = db2linear(SettingsManager.music_volume)
	$TabContainer/Audio/VolumeSlider.value = db2linear(SettingsManager.master_volume)
	$TabContainer/Game/FOVSlider.value = SettingsManager.camera_fov
	$TabContainer/Game/SensitivitySlider.value = SettingsManager.mouse_sensitivity
	$TabContainer/Game/HeadBob.pressed = SettingsManager.head_bobbing
	$TabContainer/Game/SpeedrunMode.pressed = SettingsManager.speedrun_mode
	$TabContainer/Game/SkipTutorial.pressed = SettingsManager.skip_tutorial
	$TabContainer/Game/BindUse/BindInteract.select(SettingsManager.use_key)

func _ready():
	fov_text.text = "FOV: " + str(fov_slider.value)
	update_settings()

func _on_Fullscreen_toggled(button_pressed):
	SettingsManager.fullscreen = button_pressed
	if not OS.get_name() == "HTML5":
		OS.window_fullscreen = button_pressed
		OS.window_size = Vector2(640, 480)

func _on_Vsync_toggled(button_pressed):
	SettingsManager.vsync_enabled = button_pressed
	OS.set_use_vsync(button_pressed)

func _on_HeadBob_toggled(button_pressed):
	SettingsManager.head_bobbing = button_pressed

func _on_FOVSlider_value_changed(value):
	SettingsManager.camera_fov = value
	fov_text.text = "FOV: " + str(fov_slider.value)

func _on_SensitivitySlider_value_changed(value):
	SettingsManager.mouse_sensitivity = value

func _on_Default_pressed():
	SettingsManager.default_settings()
	update_settings()

func _on_SpeedrunMode_toggled(button_pressed):
	GlobalFlags.speedrun_mode = button_pressed
	SettingsManager.speedrun_mode = GlobalFlags.speedrun_mode

func _on_SkipTutorial_toggled(button_pressed):
	SettingsManager.skip_tutorial = button_pressed
