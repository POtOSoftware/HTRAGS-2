extends StaticBody

func interact():
	GlobalStats.player_money += 60
	queue_free()
