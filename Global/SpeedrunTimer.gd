extends Node

var time = 0
var timer_on = true
var time_passed

func update_time(delta):
	var mils
	var secs
	var mins
	var hours
	
	if timer_on:
		time += delta
		
		mils = fmod(time, 1)*1000
		secs = fmod(time,60)
		mins = fmod(time, 60*60) / 60
		hours = fmod(fmod(time,3600 * 60) / 3600,24) # I'm just as confused as you are
		
		time_passed = "%02d : %02d : %02d : %03d" % [hours,mins,secs,mils]
	
	return time_passed
