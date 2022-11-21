extends Area

func _on_ShopliftTrigger_body_entered(body):
	if body.name == "Player" and not GlobalFlags.game_paid_for:
		$"../../GodlyGamesBuilding/Counter/Clerk/Dialogue/PayUp".play()
		$CollisionShape.disabled = true
