extends Area

func _on_FlatEarthTrigger_body_entered(body):
	if body.name == "Player":
		EndingManager.end_game("Damn, I guess they were right...")
