extends RigidBody

var smashed : bool = false

func interact():
	if not smashed:
		smashed = true
		apply_impulse(translation, Vector3(0,0,25))
		$AlarmSFX.playing = false
		$"../SmashSFX".play()
		$"../../../..".alarm_clock_demolished = true
		
		$"../../../../Player/AnimationPlayer".play("wake_up2")
		
		#yield(get_tree().create_timer(1.5), "timeout")
		#queue_free()
