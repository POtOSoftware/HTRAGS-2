# https://www.youtube.com/watch?v=Nn2mi5sI8bM

# If there's no comments somewhere, there's three possibilities
# 1. I forgor
# 2. I think that it's self-explanitory (a stupid thought if it's something like C/C++, but we're in GDScript (similar to Python) so it's not completely stupid)
# 3. I don't understand how it works (most likely)
extends KinematicBody

const JOY_DEADZONE = 0.2
const JOY_AXIS_RESCALE = 1.0/(1.0-JOY_DEADZONE)
const JOY_ROTATION_MULTIPLIER = 200.0 * PI / 180.0

export var speed : int = 10
export var can_move : bool = true
export var can_look : bool = true
export var can_sprint : bool = true
export var can_jump : bool = true
export var can_crouch : bool = true
export var can_interact : bool = true
export var cutscene : bool = false

# Movement variables
var h_acceleration = 6
var air_acceleration = 1
var normal_acceleration = 6
var gravity = 20
var jump_power = 10
var full_contact = false
var default_height = 3
var crouch_height = 0.5
var is_crouching = false

# Sets the mouse sensitivity to whatever the player has set in the settings
var mouse_sensitivity = SettingsManager.mouse_sensitivity

# Some more movement variables, but they're Vector3's this time
var direction = Vector3()
var h_velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()

var object

# Node variables
onready var head = $Head
onready var camera = $Head/Camera
onready var ground_check = $GroundCheck
onready var interaction_ray = $Head/Camera/InteractionRay
onready var collision = $Body
onready var foot_collision = $Foot
onready var animation = $Head/Camera/AnimationPlayer

# UI Nodes. It's for optimization, though the performance gain is probably next to nothing
onready var ui_root = $UILayer/UI
onready var ui_hand = $UILayer/UI/Hand
onready var ui_speech = $UILayer/UI/Speech
onready var ui_crosshair = $UILayer/UI/Crosshair

var energy_restored = true

# This is ran on the first frame after all the nodes n' such are ready to be used
# _init() is ran on the first frame that execution starts, so anytime you try to access a node in that function will not work
# Why did I just write a tutorial? I doubt many people will see this anyways...
# Shoot me an email (kylekailihiwa@gmail.com) or Discord DM (POtO Software#3325) if you see this, I'll probably send a face reveal
func _ready():
	# Captures the mouse input (obviously) when the player is in the current scene
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Set the camera fov to the value of the fov slider in the settings
	camera.fov = SettingsManager.camera_fov
	$Head/Camera/InteractionRay.add_exception($".")

func _input(event):
	# Detecting mouse input, and checks if the player can look
	if event is InputEventMouseMotion and can_look:
		# Rotates the player on the y-axis when the player moves their mouse on the x-axis... it makes sense I swear
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		# Rotates the camera up/down (pretty much) when the player moves their mouse on the y-axis
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		# Limits how far the player can look up/down
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func _physics_process(delta):
	direction = Vector3()
	
	full_contact = ground_check.is_colliding()
	
	# If the player is in a cutscene, disable the collison boxes
	collision.disabled = cutscene
	foot_collision.disabled = cutscene
	
	SpeedrunTimer.timer_on = not cutscene
	
	## INTERACTION CHECK ##
	if interaction_ray.is_colliding():
		object = interaction_ray.get_collider()
		if object.has_method("interact"):
			ui_hand.visible = true
			ui_crosshair.visible = false
		elif object.has_method("speak"):
			ui_speech.visible = true
			ui_crosshair.visible = false
		else:
			ui_hand.visible = false
			ui_speech.visible = false
			ui_crosshair.visible = true
	else:
		ui_hand.visible = false
		ui_speech.visible = false
		ui_crosshair.visible = true
	# Duplicated the above else: block just so the hand goes away after you look away from an interactable object
	# Without it, the hand would stay until the interaction ray is not colliding with anything
	## END INTERACTION CHECK ##
	
	## GRAVITY CODE ##
	# Disable the gravity if the player is in a cutscene
	if not cutscene:
		if not is_on_floor():
			gravity_vec += Vector3.DOWN * gravity * delta
			h_acceleration = air_acceleration
		elif is_on_floor() and full_contact:
			gravity_vec = -get_floor_normal() * gravity
			h_acceleration = normal_acceleration
		else:
			gravity_vec = -get_floor_normal()
			h_acceleration = normal_acceleration
	## END GRAVITY CODE ##
	if can_move and not cutscene:
		if Input.is_action_just_pressed("jump") and (is_on_floor() or ground_check.is_colliding()) and can_jump:
			gravity_vec = Vector3.UP * jump_power
			GlobalStats.times_jumped += 1
		
		if can_sprint:
			if Input.is_action_pressed("sprint") and not is_crouching:
				# Double the player speed when they hold shift
				speed = 20
			if Input.is_action_just_released("sprint"):
				# Return the speed to normal after releasing shift 
				speed = 10
		
		if can_crouch:
			# Doesn't work the best, but it's good enough
			if Input.is_action_just_pressed("crouch"):
				# Halves the player's height, it messes up the sensitivity (somehow) but it's not a huge deal because this isn't a competitive shooter
				scale.y = 0.5
				speed = 5
				is_crouching = true
			if Input.is_action_just_released("crouch"):
				scale.y = 1
				# This jank prevents a speed boost in the opening of the game
				if energy_restored:
					speed = 10
				else:
					speed = 7
				is_crouching = false
		
		## MOVEMENT CODE ##
		if Input.is_action_pressed("move_forward"):
			direction -= transform.basis.z
		elif Input.is_action_pressed("move_backward"):
			direction += transform.basis.z
		if Input.is_action_pressed("move_left"):
			direction -= transform.basis.x
		elif Input.is_action_pressed("move_right"):
			direction += transform.basis.x
		## END MOVEMENT CODE ##
	
	## CONTROLLER CAMERA MOVEMENT ##
	if can_look:
		var xAxis = Input.get_joy_axis(0, JOY_AXIS_2)
		if abs(xAxis) > JOY_DEADZONE:
			if xAxis > 0:
				xAxis = (xAxis-JOY_DEADZONE) * JOY_AXIS_RESCALE
			else:
				xAxis = (xAxis+JOY_DEADZONE) * JOY_AXIS_RESCALE
			rotate_object_local(Vector3.UP, -xAxis * delta * JOY_ROTATION_MULTIPLIER)
		
		var yAxis = Input.get_joy_axis(0, JOY_AXIS_3)
		if abs(yAxis) > JOY_DEADZONE:
			if yAxis > 0:
				yAxis = (yAxis-JOY_DEADZONE) * JOY_AXIS_RESCALE
			else:
				yAxis = (yAxis+JOY_DEADZONE) * JOY_AXIS_RESCALE
			head.rotate_object_local(Vector3.RIGHT, -yAxis * delta * JOY_ROTATION_MULTIPLIER)
			head.rotation.x = clamp(head.rotation.x, -1.0, 1.0)
	## END CONTROLLER CAMERA MOVEMENT ##
	
	## INTERACTION CODE ##
	if Input.is_action_just_pressed("interact") and can_interact:
		if interaction_ray.is_colliding():
			#print("Interacting with " + object.get_name())
			if object.has_method("interact"):
				object.interact()
				GlobalStats.objects_interacted += 1
			elif object.has_method("speak"):
				object.speak()
				GlobalStats.npc_spoke += 1
	## END INTERACTION CODE ##
	
	# If the player is moving, do this stuff
	if direction != Vector3():
		# If the player isn't in the air and head bobbing is enabled, play the head bobbing animation
		if ground_check.is_colliding() and SettingsManager.head_bobbing:
			animation.play("Head Bob")
	
	# Some junk that I don't really understand but is required so the movement doesn't feel like hot garbage
	direction = direction.normalized()
	h_velocity = h_velocity.linear_interpolate(direction * speed, h_acceleration * delta)
	movement.z = h_velocity.z + gravity_vec.z
	movement.x = h_velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
	
	# The get_floor_velocity() variable is supposed to make it to where the player will stay on moving platforms... but they don't
	move_and_slide(movement + get_floor_velocity(), Vector3.UP)
	
	## DEBUG COMMANDS ##
	if GlobalFlags.debug:
		if Input.is_action_just_pressed("debug_hide_ui"):
			ui_root.visible = not ui_root.visible
	## END DEBUG COMMANDS ##
