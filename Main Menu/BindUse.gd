extends Control

var ev = InputEventKey.new()
var evm = InputEventMouseButton.new()

func _ready():
	$BindInteract.select(SettingsManager.use_key)
	update_key(SettingsManager.use_key)

func update_key(key_index : int):
	InputMap.action_erase_events("interact")
	match key_index:
		0:
			ev.scancode = KEY_E
			InputMap.action_add_event("interact", ev)
			print(InputMap.get_action_list("interact"))
		1:
			evm.button_index = BUTTON_LEFT
			InputMap.action_add_event("interact", evm)
			print(InputMap.get_action_list("interact"))
		2:
			evm.button_index = BUTTON_RIGHT
			InputMap.action_add_event("interact", evm)
			print(InputMap.get_action_list("interact"))
		3:
			evm.button_index = BUTTON_MIDDLE
			InputMap.action_add_event("interact", evm)

func _on_BindInteract_item_selected(index):
	print(index)
	SettingsManager.use_key = index
	update_key(index)
