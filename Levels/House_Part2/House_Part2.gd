extends Spatial

func _on_HeartAttackTimer_timeout():
	EndingManager.end_game("Reject energy drink. Return to coffee.")
