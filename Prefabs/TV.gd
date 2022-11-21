extends StaticBody

var tv_off = true

func interact():
	tv_off = !tv_off
	
	$Panel/Screen2.visible = tv_off
