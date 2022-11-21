extends Label

func _ready():
	visible = GlobalFlags.speedrun_mode

func _physics_process(delta):
	if GlobalFlags.speedrun_mode and SpeedrunTimer.timer_on:
		text = SpeedrunTimer.update_time(delta)
