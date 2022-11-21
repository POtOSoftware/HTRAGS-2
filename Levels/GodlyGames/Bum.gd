extends StaticBody

func speak():
	$AnimationPlayer.play("spare")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "spare":
		$UI.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$"../Player".can_move = false
		$"../Player".can_look = false
		$"../Player".can_interact = false

func _on_Yes_pressed():
	$UI.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"../Player".can_move = true
	$"../Player".can_look = true
	$"../Player".can_interact = true
	GlobalStats.player_money -= 5
	$AnimationPlayer.play("thankyou")

func _on_No_pressed():
	$UI.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"../Player".can_move = true
	$"../Player".can_look = true
	$"../Player".can_interact = true
	$AnimationPlayer.play("itsokay")
