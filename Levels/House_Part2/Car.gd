extends StaticBody

func interact():
	$"../Player".cutscene = true
	$"../CutsceneCamera".current = true
	$"../Player".queue_free()
	
	if GlobalFlags.nrg_drank > 0:
		$AnimationPlayer.play("Drive")
	else:
		$AnimationPlayer.play("DriveCrash")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Drive":
		LevelManager.load_level("GodlyGames/GodlyGames.tscn")
	if anim_name == "DriveCrash":
		EndingManager.end_game("To hell with everybody's safety! I have to get this god damn game!")
