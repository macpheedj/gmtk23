extends Node2D
class_name Conversation


var dialogueIndex = 0
# TODO: read this from a json file or something
var dialogues = [
	{
		"speaker": "Prince Gog",
		"portrait": "gog_default",
		"message": "Blather blather blather this is test dialogue don't read too much into it, no big deal I am after all a prince."
	},
	{
		"speaker": "Prince Gog",
		"portrait": "gog_angry",
		"message": "Now I'm angry!!!"
	}
]


func _ready():
	displayNextMessage()


func isFinishedTyping() -> bool:
	return $SpeechBorder/SpeechBG/Speech.visible_characters >= $SpeechBorder/SpeechBG/Speech.text.length()

func displayNextMessage():
	var dialogue = dialogues[dialogueIndex]
	var portrait = load("res://assets/" + dialogue.portrait + ".png")
	$SpeakerPortrait.set_texture(portrait)
	$SpeechBorder/SpeechBG/Speech.visible_characters = 0
	$SpeechBorder/SpeechBG/Speech.text = dialogue.message
	$SpeakerBorder/SpeakerBG/Speaker.text = "[center]" + dialogue.speaker + "[/center]"

	if $TypeTimer.is_stopped():
		$TypeTimer.start()


func advanceMessage():
	if dialogueIndex == dialogues.size() - 1:
		print("bzzt wrongo")
	else:
		dialogueIndex += 1
		displayNextMessage()


func _process(_delta):
	if Input.is_action_just_pressed("text_advance"):
		if isFinishedTyping():
			advanceMessage()
		else:
			$SpeechBorder/SpeechBG/Speech.visible_characters = $SpeechBorder/SpeechBG/Speech.text.length()


func _on_type_timer_timeout():
	if not isFinishedTyping():
		$SpeechBorder/SpeechBG/Speech.visible_characters += 1
	else:
		$TypeTimer.stop()
