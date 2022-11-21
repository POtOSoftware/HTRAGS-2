extends StaticBody

func interact():
	GlobalFlags.game_on_hold = true
	$AnimationPlayer.play("phonecall")
