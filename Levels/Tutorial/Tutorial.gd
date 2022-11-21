extends Spatial

onready var animation = $AnimationPlayer

var STATS_LOCATION = "user://player.stats"
var directory = Directory.new()

var is_button_pressed = false

func _ready():
	animation.play("FadeIn")
	$Player/UILayer/PauseLayer/PauseMenu/VBoxContainer/Reset.text = "Skip"
	if GlobalFlags.debug:
		STATS_LOCATION = "res://player.stats"
	if directory.file_exists(STATS_LOCATION):
		$UI/SkipNotification.visible = true

# It just waits a second, to make sure that the level is visible to the player
func _on_WaitForLoad_timeout():
	$VoiceClips/Welcome.playing = true
	$Timers/WaitForLoad.queue_free()

func _on_Welcome_finished():
	$VoiceClips/Welcome.queue_free()
	$VoiceClips/Looking.play()

func _on_Looking_finished():
	$VoiceClips/Looking.queue_free()
	$Player.can_look = true

func _on_Amazing_finished():
	$VoiceClips/Amazing.queue_free()
	$VoiceClips/Moving.play()

func _on_Moving_finished():
	$VoiceClips/Moving.queue_free()
	$Player.can_move = true
	$Player.cutscene = false

func _on_Jumping_finished():
	$VoiceClips/Jumping.queue_free()
	$Player.can_move = true

func _on_JumpTrigger_body_entered(body):
	if body.name == "Player":
		$Player.can_jump = true
		$VoiceClips/Speechless.queue_free() # This is to prevent the tutorial speech from playing over itself in case the player is too fast
		$VoiceClips/Jumping.play()
		$CSGCombiner/Section1/JumpTrigger/CollisionShape.disabled = true

func _on_CrouchTrigger_body_entered(body):
	if body.name == "Player":
		$Player.can_crouch = true
		$VoiceClips/Jumping.queue_free()
		$VoiceClips/Crouching.play()
		$CSGCombiner/Section2/CrouchTrigger/CollisionShape.disabled = true

func _on_SprintingTrigger_body_entered(body):
	if body.name == "Player":
		$Player.can_sprint = true
		$VoiceClips/Crouching.queue_free()
		$VoiceClips/Sprinting.play()
		$CSGCombiner/Section2/SprintingTrigger/CollisionShape.disabled = true

func _on_InteractionTrigger_body_entered(body):
	if body.name == "Player":
		$Player.can_interact = true
		$VoiceClips/Sprinting.queue_free()
		$VoiceClips/Interacting.play()
		$CSGCombiner/Section3/InteractionTrigger/CollisionShape.disabled = true

func button_pressed():
	$VoiceClips/Interacting.queue_free()
	$VoiceClips/Congratulations.play()
	animation.play("DiplomaDescent")
	is_button_pressed = true



