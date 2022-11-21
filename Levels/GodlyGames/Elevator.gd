extends KinematicBody

func _ready():
	yield(get_tree().create_timer(10), "timeout")
	$AnimationPlayer.play("Elevator")
