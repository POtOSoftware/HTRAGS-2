extends StaticBody

func _ready():
	visible = GlobalFlags.game_on_hold
	$CollisionShape.disabled = not GlobalFlags.game_on_hold

func interact():
	GlobalFlags.game_grabbed = true
	$"../../../Triggers/ShopliftTrigger/CollisionShape".disabled = false
	queue_free()
