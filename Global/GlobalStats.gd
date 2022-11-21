# This stores the player stats, named it GlobalStats because it's, well, global across any scenes
extends Node

var SAVE_PATH = "user://player.stats"
var ENCRYPT_PASS = "Bruhr AMougug s ssususussysys"

var time = 0
var secs
var mins
var hours

func _ready():
	if GlobalFlags.debug:
		SAVE_PATH = "res://player.stats"
		#ENCRYPT_PASS = ""
	load_stats()

## PLAYER STATS ##
var player_money : int = 0
var times_completed : int = 0
var times_jumped : int = 0
var total_nrg_drank : int = 0
var objects_interacted : int = 0
var npc_spoke : int = 0
var total_time_passed : String = "00 : 00 : 00"
## PLAYER STATS ##

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# You will never escape the stats being saved
		save_stats()

func _process(delta):
	time += delta
	
	secs = fmod(time,60)
	mins = fmod(time,60*60) / 60
	hours = fmod(fmod(time,3600 * 80) / 3600,24)
	
	total_time_passed = "%02d : %02d : %02d" % [hours,mins,secs]

func save_stats():
	var stat_file = ConfigFile.new()
	
	stat_file.set_value("stats", "times_completed", times_completed)
	stat_file.set_value("stats", "times_jumped", times_jumped)
	stat_file.set_value("stats", "total_nrg_drank", total_nrg_drank)
	stat_file.set_value("stats", "objects_interacted", objects_interacted)
	stat_file.set_value("stats", "npc_spoke", npc_spoke)
	stat_file.set_value("stats", "total_time_passed", total_time_passed)
	
	# Don't encrypt the save file if it's a debug build
	if GlobalFlags.debug:
		stat_file.save(SAVE_PATH)
	else:
		stat_file.save_encrypted_pass(SAVE_PATH, ENCRYPT_PASS)

func load_stats():
	var err
	var stat_file = ConfigFile.new()
	# If it tries to do an encrypted load on an unencrypted file, it gets real unhappy
	if GlobalFlags.debug:
		err = stat_file.load(SAVE_PATH)
	else:
		err = stat_file.load_encrypted_pass(SAVE_PATH, ENCRYPT_PASS)
	
	if err == OK:
		times_completed = stat_file.get_value("stats", "times_completed")
		times_jumped = stat_file.get_value("stats", "times_jumped")
		total_nrg_drank = stat_file.get_value("stats", "total_nrg_drank")
		objects_interacted = stat_file.get_value("stats", "objects_interacted")
		npc_spoke = stat_file.get_value("stats", "npc_spoke")
		total_time_passed = stat_file.get_value("stats", "total_time_passed")
	
	return err
