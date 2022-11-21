extends Spatial

func _ready():
	$PeterCube/AnimationPlayer.play("spin")

func interact():
	$FunniSFX.play()
