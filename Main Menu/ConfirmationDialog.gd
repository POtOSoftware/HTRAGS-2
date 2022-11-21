extends ConfirmationDialog

var rng = RandomNumberGenerator.new()

var quit_taunts = ["Are you seriously quitting?",
					"Come on man, give it another chance!",
					"If you quit, I'll slash your tires. Do you still want to quit?",
					"Giving up so soon, dude? ... Or dudette?",
					"If you quit, it's your loss man... or ma'am.",
					"WAIT! DON'T QUIT! If you stay, you'll get $100,000! Don't you want that?"]

func _ready():
	rng.randomize()
	
	# Why Godot doesn't let me change this stuff in the editor I don't know
	get_ok().text = "Yes"
	get_ok().focus_mode = Control.FOCUS_NONE
	get_cancel().text = "No"
	get_cancel().focus_mode = Control.FOCUS_ALL
	get_close_button().visible = false
	
	dialog_text = quit_taunts[rng.randi_range(0, quit_taunts.size() -1)]

func _on_ConfirmationDialog_confirmed():
	get_tree().quit()
