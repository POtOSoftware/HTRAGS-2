extends Control

func _on_Tutorial_pressed():
	LevelManager.load_level("Tutorial/Tutorial.tscn")

func _on_House_pressed():
	LevelManager.load_level("House/House.tscn")

func _on_GodlyGames_pressed():
	LevelManager.load_level("GodlyGames/GodlyGames.tscn")

func _on_House2_pressed():
	LevelManager.load_level("House_Part2/House_Part2.tscn")
