extends Button

func _ready():
	# Sometimes the stats animation stops being submissive and breedable and decides that it's gonna show the stats anyways
	# Playing the RESET "animation" basically guarantees that the stats animation stays submissive and breedable and only shows up when commanded to
	$AnimationPlayer.play("RESET")
	
	GlobalStats.load_stats()
	$Panel/VBoxContainer/TotalCompleted.text = "Times Completed: " + str(GlobalStats.times_completed)
	$Panel/VBoxContainer/TotalJumped.text = "Times Jumped: " + str(GlobalStats.times_jumped)
	$Panel/VBoxContainer/TotalNRG.text = "G4m3r NRG Drank: " + str(GlobalStats.total_nrg_drank)
	$Panel/VBoxContainer/TotalObject.text = "Objects Interacted With: " + str(GlobalStats.objects_interacted)
	$Panel/VBoxContainer/TotalSpeak.text = "NPCs Spoken With: " + str(GlobalStats.npc_spoke)
	$Panel/VBoxContainer/TotalTime.text = "Total Time Played: " + GlobalStats.total_time_passed

func _on_Stats_toggled(button_pressed):
	if button_pressed:
		$AnimationPlayer.play("Expand")
	else:
		$AnimationPlayer.play_backwards("Expand")
