extends Node2D
class_name Conversation


var awaitingPrompt = false
var speakers = []
var shownPrompts = []
var dialogueIndex = 0
# TODO: read this from a json file or something
var dialogues = [
	{
		"speaker": "Prince Gog",
		"portrait": "gog_default",
		"message": "Blather blather blather"
	},
	{
		"speaker": "Chessa",
		"portrait": "chessa_default",
		"message": "I am here"
	},
	{
		"speaker": "Prince Gog",
		"portrait": "gog_angry",
		"message": "blah blah blah",
		"prompts": [
			"Hello there",
			"I didn't see you there",
			"You are here, it seems"
		],
		"responses": [
			{
				"speaker": "Chessa",
				"portrait": "chessa_default",
				"message": "Why I never!",
			},
			{
				"speaker": "Chessa",
				"portrait": "chessa_default",
				"message": "I like that",
			},
			{
				"speaker": "Chessa",
				"portrait": "chessa_default",
				"message": "Fart butt fart butt",
			},
		]
	},
	{
		"speaker": "Chessa",
		"portrait": "chessa_default",
		"message": "lol"
	},
]


func _ready():
	countSpeakers()
	displayNextMessage(null)


func countSpeakers():
	dialogues.map(func(item): if speakers.find(item.speaker) == -1: speakers.push_back(item.speaker))
	return speakers.size()


func isFinishedTyping() -> bool:
	return $Speech/BG/Text.visible_characters >= $Speech/BG/Text.text.length()


func displayNextMessage(overrideDialogue):
	var dialogue = overrideDialogue if overrideDialogue else dialogues[dialogueIndex]
	var portrait = load("res://assets/" + dialogue.portrait + ".png")

	# print("speaker name: " + dialogue.speaker)
	# print("index: " + str(speakers.find(dialogue.speaker)))

	if speakers.find(dialogue.speaker) % 2 == 0:
		$SpeakerPortraitR.set_texture(portrait)
		$Speech/BG/Text.visible_characters = 0
		$Speech/BG/Text.text = dialogue.message
		$SpeakerR.visible = true
		$SpeakerR/BG/Name.text = "[center]" + dialogue.speaker + "[/center]"

		if $SpeakerPortraitR.position.y != 390:
			$SpeakerPortraitR.position.y = 390
			$SpeakerPortraitL.position.y = 430

	else:
		$SpeakerPortraitL.set_texture(portrait)
		$Speech/BG/Text.visible_characters = 0
		$Speech/BG/Text.text = dialogue.message
		$SpeakerL.visible = true
		$SpeakerL/BG/Name.text = "[center]" + dialogue.speaker + "[/center]"

		if $SpeakerPortraitL.position.y != 390:
			$SpeakerPortraitL.position.y = 390
			$SpeakerPortraitR.position.y = 430


	if $TypeTimer.is_stopped():
		$TypeTimer.start()

func togglePrompts():
	for prompt in [$Prompt1, $Prompt2, $Prompt3]:
		prompt.visible = not prompt.visible
		prompt.disabled = not prompt.disabled


func displayPrompt(prompts):
	shownPrompts.push_back(dialogueIndex) # save reference to prompt @ index so we dont double-show it
	$Prompt1.text = prompts[0]
	$Prompt2.text = prompts[1]
	$Prompt3.text = prompts[2]
	togglePrompts()


func advanceMessage():
	if dialogueIndex == dialogues.size() - 1:
		print("bzzt wrongo")
	else:
		dialogueIndex += 1
		displayNextMessage(null)


func _process(_delta):
	if not awaitingPrompt and Input.is_action_just_pressed("text_advance"):
		if isFinishedTyping():
			advanceMessage()
		else:
			$Speech/BG/Text.visible_characters = $Speech/BG/Text.text.length()


func _on_type_timer_timeout():
	if not isFinishedTyping():
		$Speech/BG/Text.visible_characters += 1
	else:
		$TypeTimer.stop()
		if dialogues[dialogueIndex].has("prompts") and shownPrompts.find(dialogueIndex) == -1:
			awaitingPrompt = true
			displayPrompt(dialogues[dialogueIndex].prompts)


# TODO: update state if callback represents correct answer linking prince + princess
func _on_prompt_1_pressed():
	awaitingPrompt = false
	togglePrompts()
	displayNextMessage(dialogues[dialogueIndex].responses[0])


func _on_prompt_2_pressed():
	awaitingPrompt = false
	togglePrompts()
	displayNextMessage(dialogues[dialogueIndex].responses[1])


func _on_prompt_3_pressed():
	awaitingPrompt = false
	togglePrompts()
	displayNextMessage(dialogues[dialogueIndex].responses[2])
