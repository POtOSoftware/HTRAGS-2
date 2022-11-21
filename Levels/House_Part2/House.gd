extends Spatial

var alarm_clock_demolished = false
var true_ending = false

func _ready():
	## RESET GAME VARS ##
	GlobalFlags.nrg_drank = 0
	GlobalFlags.game_on_hold = false
	GlobalFlags.game_grabbed = false
	GlobalFlags.game_paid_for = false
	GlobalFlags.heart_attack = false
	## RESET GAME VARS
	
	$Player.energy_restored = false
	
	#SpeedrunTimer.time = 0
	$Player/AnimationPlayer.play("wake_up")

func heart_attack():
	$Player.can_move = false
	$Player.can_jump = false
	$HeartBeatSFX.play()
	#yield(get_tree().create_timer(5), "timeout")
	$Timers/HeartAttackTimer.start()
	#EndingManager.end_game("Reject energy drink. Return to coffee.")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "wake_up":
		$Player.can_look = true
		$Timers/TrueTimer.start()
	
		if true_ending:
			EndingManager.end_game("The carbon monoxide helps me sleep")

	if anim_name == "wake_up2":
		$Player.can_move = true
		$Player.cutscene = false

func _on_TrueTimer_timeout():
	if not alarm_clock_demolished:
		$Player.can_look = false
		$Player/AnimationPlayer.play_backwards("wake_up")
		true_ending = true

func _on_HeartAttackTimer_timeout():
	EndingManager.end_game("Reject energy drink. Return to coffee.")
