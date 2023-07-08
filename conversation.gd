extends Node2D
class_name Conversation


var speakers = []
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
	},
	{
		"speaker": "Prince Gog",
		"portrait": "gog_blush",
		"message": "Oh that's kinda cute actually"
	},
	{
		"speaker": "Prince Goog",
		"portrait": "gog_default",
		"message": "And I'm here too"
	},
	{
		"speaker": "Prince Gogog",
		"portrait": "gog_angry",
		"message": "So am I don't forget about me!"
	}
]


func _ready():
	countSpeakers()
	displayNextMessage()


func countSpeakers():
	dialogues.map(func(item): if speakers.find(item.speaker) == -1: speakers.push_back(item.speaker))
	return speakers.size()


func isFinishedTyping() -> bool:
	return $SpeechBorder/SpeechBG/Speech.visible_characters >= $SpeechBorder/SpeechBG/Speech.text.length()


func displayNextMessage():
	var dialogue = dialogues[dialogueIndex]
	var portrait = load("res://assets/" + dialogue.portrait + ".png")

	print("speaker name: " + dialogue.speaker)
	print("index: " + str(speakers.find(dialogue.speaker)))

	if speakers.find(dialogue.speaker) % 2 == 0:
		$SpeakerPortraitR.set_texture(portrait)
		$SpeakerBorderR.visible = true
		$SpeechBorder/SpeechBG/Speech.visible_characters = 0
		$SpeechBorder/SpeechBG/Speech.text = dialogue.message
		$SpeakerBorderR/SpeakerBGR/SpeakerR.text = "[center]" + dialogue.speaker + "[/center]"

		if $SpeakerPortraitR.position.y != 390:
			$SpeakerPortraitR.position.y = 390
			$SpeakerPortraitL.position.y = 410

	else:
		$SpeakerPortraitL.set_texture(portrait)
		$SpeakerBorderL.visible = true
		$SpeechBorder/SpeechBG/Speech.visible_characters = 0
		$SpeechBorder/SpeechBG/Speech.text = dialogue.message
		$SpeakerBorderL/SpeakerBGL/SpeakerL.text = "[center]" + dialogue.speaker + "[/center]"

		if $SpeakerPortraitL.position.y != 390:
			$SpeakerPortraitL.position.y = 390
			$SpeakerPortraitR.position.y = 410

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
