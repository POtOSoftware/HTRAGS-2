extends Control

# The classified military information is right here:
# https://bit.ly/3A3eJTu
# But be quick, I don't know how long I can keep the link in here
# If I go missing or commit suicide, you know why

var rng = RandomNumberGenerator.new()
var super_rare_random_chance

var quotes = [ 
	"my wife said its her or the game",
	"super gaming house 3D in theaters tomorrow",
	"Keep On Rollin' Baby",
	"i have hidden classified military information in the source code",
	"it starts with one thing i dont know why it doesnt even matter how hard you try keep that in mind i designed this rhyme to explain in due time all i know",
	"theres a 1 in 100000 chance for something funny to happen",
	"you are about to play one of the games of all time",
	"you are currently in a coma. wake up. wake up. wake up.",
	"Sponsored by Marlboro Cigarettes",
	"Shoutout to SimpleFlips",
	"Shoutout to Naivist",
	"\"Xbox, record that\"",
	"It just works",
	"It's gummy time",
	"PM died for this"
]

func _unhandled_input(event):
	# Skipping the logo screen when any key is pressed
	if event.is_pressed():
		get_tree().change_scene("res://Main Menu/Main Menu.tscn")

func _init():
	SettingsManager.load_settings()
	
	rng.randomize()
	super_rare_random_chance = rng.randi_range(0, 100000)
	
	if not OS.get_name() == "HTML5":
		OS.window_fullscreen = SettingsManager.fullscreen
		OS.vsync_enabled = SettingsManager.vsync_enabled

func _ready():

	
	$Quote.text = quotes[rng.randi_range(0, quotes.size() -1)]
	if super_rare_random_chance == 100000:
		$Logo.texture = load("res://Textures/UI/peter2012.jpeg")
		$Quote.text = quotes[2] # I don't know why but this quote just fits the image perfectly
	
	$AnimationPlayer.play("logo")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Main Menu/Main Menu.tscn")
