extends Button

func _ready():
	visible = GlobalFlags.debug

func _on_dbgLevelSelect_pressed():
	get_tree().change_scene("res://Main Menu/LevelSelect.tscn")
