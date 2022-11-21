extends Label

func _process(delta):
	if MessageManager.message_displayed and not visible:
		$"../MessageTimer".start()
		text = MessageManager.message
		visible = true
	if not MessageManager.message_displayed:
		visible = false
		text = ""

func _on_MessageTimer_timeout():
	MessageManager.message_displayed = false
