extends StaticBody

onready var animation = $AnimationPlayer

func interact():
	if GlobalFlags.game_grabbed:
		if GlobalFlags.game_paid_for:
			# Good Ending
			EndingManager.end_game("Ability to play HTRAGS 2 coming soon (Good Ending)")
		elif GlobalStats.player_money < 60:
			animation.play("Drive_Back_Home")
			yield(animation, "animation_finished")
			LevelManager.load_level("Levels/House_Part2")
		else:
			# Sigma Ending 2.0
			EndingManager.end_game("Sorry folks, California Prop 47 backs me up on this one")
	elif GlobalFlags.bad_ending:
		# Bad Ending
		EndingManager.end_game("There's no point to life anymore (Bad Ending)")
	else:
		MessageManager.display_message("Gotta get this game first")
