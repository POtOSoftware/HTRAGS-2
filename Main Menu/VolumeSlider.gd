#https://www.gdquest.com/tutorial/godot/audio/volume-slider/

extends HSlider

export var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)

onready var sfx_test = $"../SFXTest"

func _ready() -> void:
	value = db2linear(AudioServer.get_bus_volume_db(_bus))


func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
	# This is probably the WRONG way of doing this, but it works so who cares
	match audio_bus_name:
		"Master":
			SettingsManager.master_volume = linear2db(value)
		"Music":
			SettingsManager.music_volume = linear2db(value)
		"SFX":
			SettingsManager.sfx_volume = linear2db(value)
	

func _on_VolumeSlider_mouse_exited():
	release_focus()
