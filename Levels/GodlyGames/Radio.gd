extends AudioStreamPlayer3D


func _ready():
	# Loads the music that's set in the Speakers node
	stream = load($"..".music)
	playing = true
