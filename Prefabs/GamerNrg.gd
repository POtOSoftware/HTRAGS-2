extends RigidBody

func interact():
	MessageManager.display_message("Energy Restored")
	GlobalFlags.nrg_drank += 1
	# I don't feel like rewriting this stuff, so this ass is gonna have to do
	GlobalStats.total_nrg_drank = GlobalFlags.nrg_drank
	
	$"../../../../../../Player".speed = 10
	$"../../../../../../Player".energy_restored = true
	$"../../../../../../Player".can_jump = true
	$"../../../../../../Player".can_sprint = true
	
	# If the player drinks all the cans, make them have a heart attack
	if GlobalFlags.nrg_drank == 21:
		MessageManager.display_message("Heart Attack!")
		$"../../../../../..".heart_attack()
	
	print(GlobalStats.total_nrg_drank)
	
	queue_free()
