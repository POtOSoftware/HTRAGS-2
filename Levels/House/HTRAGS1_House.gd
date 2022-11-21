extends Spatial

func _on_WarningTrigger_body_entered(body):
	if body.name == "Player":
		$Coppers/PissOff.play()

func _on_ArrestTrigger_body_entered(body):
	if body.name == "Player":
		EndingManager.end_game("Well how was I supposed to know that's illegal?")
