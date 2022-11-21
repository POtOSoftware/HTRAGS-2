extends StaticBody

func interact():
	$"../../..".button_pressed()
	$"../Explosion".visible = true
	$"../Explosion".playing = true
	$"../ExplosionSFX".playing = true
	$"CollisionShape".disabled = true
	visible = false

func _on_Explosion_animation_finished():
	$"../Explosion".queue_free()
	queue_free()
