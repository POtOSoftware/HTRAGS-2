extends Control

var can_continue = false

var key_presses : int

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var tex = ImageTexture.new()
	tex.create_from_image(EndingManager.screenshot())
	$Background.texture = tex
	$AnimationPlayer.play("EndScreen")
	$EndQuote.text = EndingManager.ending_quote
	if GlobalFlags.speedrun_mode:
		$Time.visible = true
		
		# If the time isn't null (zero)
		if SpeedrunTimer.time_passed:
			$Time.text = "Time: " + SpeedrunTimer.time_passed
		else:
			$Time.text = "Time: 00 : 00 : 00 : 000"
	SpeedrunTimer.time = 0
	SpeedrunTimer.time_passed = null

func _unhandled_input(event):
	if event.is_pressed():
		key_presses += 1
		if can_continue:
			$AnimationPlayer.play("FadeOut")
		else:
			print("Wow look at you reading the debug output, what a nerd")
			if key_presses >= 10:
				print("Okay man JEEZ FINE I'LL PUT YOU BACK INTO THE MAIN MENU YOU IMPATIENT ASSWIPE")
				print("jk i still love you <3")
				get_tree().change_scene("res://Main Menu/Main Menu.tscn")

func _on_PlzWaitTimer_timeout():
	can_continue = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeOut":
		get_tree().change_scene("res://Main Menu/Main Menu.tscn")
