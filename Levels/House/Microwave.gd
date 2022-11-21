extends StaticBody

var fallout_counter = 0

func interact():
	$MicrowaveSFX.play()
	fallout_counter += 1
	
	if fallout_counter > 49:
		$Microwave.visible = false
		$Explosion.visible = true
		$CollisionShape.disabled = true
		$Explosion.play("Explosion")
		$ExplosionSFX.play()
	#EndingManager.end_game("Test ending")

func _on_Explosion_animation_finished():
	EndingManager.end_game("Don't buy the Samsung Galaxy microwave")
