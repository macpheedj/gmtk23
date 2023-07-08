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
		"speaker": "Chessa",
		"portrait": "chessa_default",
		"message": "And I'm here too"
	},
	{
		"speaker": "Prince Gogog",
		"portrait": "gog_angry",
		"message": "So am I don't forget about me!",
		"prompts": [
			"Hello there",
			"I didn't see you there",
			"You are there, it seems"
		]
	}
]


func _ready():
	countSpeakers()
	displayNextMessage()


func countSpeakers():
	dialogues.map(func(item): if speakers.find(item.speaker) == -1: speakers.push_back(item.speaker))
	return speakers.size()


func isFinishedTyping() -> bool:
	return $Speech/BG/Text.visible_characters >= $Speech/BG/Text.text.length()


func displayNextMessage():
	var dialogue = dialogues[dialogueIndex]
	var portrait = load("res://assets/" + dialogue.portrait + ".png")

	print("speaker name: " + dialogue.speaker)
	print("index: " + str(speakers.find(dialogue.speaker)))

	if speakers.find(dialogue.speaker) % 2 == 0:
		$SpeakerPortraitR.set_texture(portrait)
		$Speech/BG/Text.visible_characters = 0
		$Speech/BG/Text.text = dialogue.message
		$SpeakerR.visible = true
		$SpeakerR/BG/Name.text = "[center]" + dialogue.speaker + "[/center]"

		if $SpeakerPortraitR.position.y != 390:
			$SpeakerPortraitR.position.y = 390
			$SpeakerPortraitL.position.y = 410

	else:
		$SpeakerPortraitL.set_texture(portrait)
		$Speech/BG/Text.visible_characters = 0
		$Speech/BG/Text.text = dialogue.message
		$SpeakerL.visible = true
		$SpeakerL/BG/Name.text = "[center]" + dialogue.speaker + "[/center]"

		if $SpeakerPortraitL.position.y != 390:
			$SpeakerPortraitL.position.y = 390
			$SpeakerPortraitR.position.y = 410

	# if dialogue.prompts:
	# 	displayPrompt(dialogue.prompts)

	if $TypeTimer.is_stopped():
		$TypeTimer.start()


func displayPrompt(prompts):

	pass


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
			$Speech/BG/Text.visible_characters = $Speech/BG/Text.text.length()


func _on_type_timer_timeout():
	if not isFinishedTyping():
		$Speech/BG/Text.visible_characters += 1
	else:
		$TypeTimer.stop()
