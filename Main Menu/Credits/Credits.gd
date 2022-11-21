extends Control

func _ready():
	$AnimationPlayer.play("Credits")

func _input(event):
	if event.is_pressed():
		get_tree().change_scene("res://Main Menu/Main Menu.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Credits":
		get_tree().change_scene("res://Main Menu/Main Menu.tscn")
