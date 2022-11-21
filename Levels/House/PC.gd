extends StaticBody

var on = false

func interact():
	if on:
		$"../Desk/Monitor/Panel/Screen2".visible = true
		$"../Desk/Monitor2/Panel/Screen2".visible = true
		$Speaker.stop()
		on = false
	else:
		$"../Desk/Monitor/Panel/Screen2".visible = false
		$"../Desk/Monitor2/Panel/Screen2".visible = false
		$Speaker.play()
		on = true
