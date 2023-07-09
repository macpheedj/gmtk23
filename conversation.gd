extends Node2D
class_name Conversation


signal fadeout


var animating = false
var awaitingPrompt = false
var speakers = []
var shownPrompts = []
var dialogueIndex = 0
var dialogues = null


func setup(json):
	dialogues = json
	countSpeakers()
	displayNextMessage(null)


func setAnimating(boolean):
	animating = boolean


func countSpeakers():
	dialogues.map(func(item): if speakers.find(item.speaker) == -1: speakers.push_back(item.speaker))
	return speakers.size()


func isFinishedTyping() -> bool:
	return $Speech/BG/Text.visible_characters >= $Speech/BG/Text.text.length()


func displayNextMessage(overrideDialogue):
	var dialogue = overrideDialogue if overrideDialogue else dialogues[dialogueIndex]

	if dialogue.has("transition"):
		fadeout.emit()
		dialogueIndex += 1
		return

	var portrait = load("res://assets/" + dialogue.portrait + ".png")

	if speakers.find(dialogue.speaker) % 2 == 0:
		$SpeakerPortraitR.set_texture(portrait)
		$Speech/BG/Text.visible_characters = 0
		$Speech/BG/Text.text = dialogue.message
		$SpeakerR.visible = true
		$SpeakerR/BG/Name.text = "[center]" + dialogue.speaker + "[/center]"

		if $SpeakerPortraitR.position.y != 490:
			$SpeakerPortraitR.position.y = 490
			$SpeakerPortraitL.position.y = 530

	else:
		$SpeakerPortraitL.set_texture(portrait)
		$Speech/BG/Text.visible_characters = 0
		$Speech/BG/Text.text = dialogue.message
		$SpeakerL.visible = true
		$SpeakerL/BG/Name.text = "[center]" + dialogue.speaker + "[/center]"

		if $SpeakerPortraitL.position.y != 490:
			$SpeakerPortraitL.position.y = 490
			$SpeakerPortraitR.position.y = 530


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
	if animating:
		return

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
