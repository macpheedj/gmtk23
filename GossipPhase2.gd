extends Node2D


var dialogues = null


func _ready():
	var json = JSON.new()
	var file = FileAccess.open("res://Dialogue/gossip_phase_2.json", FileAccess.READ)
	var content = file.get_as_text()
	var error = json.parse(content)

	if error == OK:
		dialogues = json.data
		$Conversation.fadeout.connect(_on_conversation_fadeout)
		$Conversation.setup(dialogues)


func _on_conversation_fadeout():
	$Conversation.setAnimating(true)
	$FadeOut.play("FadeOut")
	await get_tree().create_timer(1).timeout
	$Conversation.displayNextMessage(null)
	$FadeIn.play("FadeIn")
	await get_tree().create_timer(1).timeout
	$Conversation.setAnimating(false)
	pass
