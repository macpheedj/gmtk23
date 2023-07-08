extends Node2D
class_name Conversation


var dialogueIndex = 0
# TODO: read this from a json file or something
var dialogues = [
	{
		"speaker": "Prince Gog",
		"portrait": "default",
		"message": "Blather blather blather this is test dialogue don't read too much into it, no big deal I am after all a prince."
	}
]


func _ready():
	displayNextMessage()
	pass


func displayNextMessage():
	$Speech.text = dialogues[dialogueIndex].message
	$Speaker.text = "[center]" + dialogues[dialogueIndex].speaker + "[/center]"

	if $TypeTimer.is_stopped():
		$TypeTimer.start()


func _on_type_timer_timeout():
	if $Speech.visible_characters < $Speech.text.length():
		$Speech.visible_characters += 1
