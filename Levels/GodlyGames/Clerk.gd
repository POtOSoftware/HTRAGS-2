extends StaticBody

func speak():
	if GlobalFlags.game_on_hold:
		if GlobalFlags.game_grabbed:
			$Dialogue/GoodEnding2.play()
			GlobalFlags.game_paid_for = true
		else:
			$Dialogue/GoodEnding1.play()
	
	if not GlobalFlags.game_on_hold:
		$AnimationPlayer.play("out_of_stock")
		GlobalFlags.bad_ending = true
