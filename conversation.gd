extends Node2D
class_name Conversation


signal fadeout
signal end


var animating = false
var awaitingPrompt = false
var speakers = []
var shownPrompts = []
var dialogueIndex = 0
var dialogues = null
var previousSpeaker = null
var previousSpeakerSide = null
var usecontroller = false

func _ready():
	$EOMPromptFloat.play("EOM_Float")

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


func narrate(message):
	$SpeakerL.visible = false
	$SpeakerR.visible = false
	$SpeakerPortraitL.visible = false
	$SpeakerPortraitR.visible = false
	$Speech/BG/Text.visible_characters = 0
	$Speech/BG/Text.text = message


func setSpeaker(swap, dialogue, portrait):
	var speakerPortrait = null
	var speaker = null
	var speakerName = null

	if (previousSpeakerSide == "RIGHT" and not swap) or (previousSpeakerSide == "LEFT" and swap):
		previousSpeakerSide = "RIGHT"
		speakerPortrait = $SpeakerPortraitR
		speakerPortrait.flip_h = true
		speaker = $SpeakerR
		speakerName = $SpeakerR/BG/Name
		if $SpeakerPortraitR.position.y != 490:
			$SpeakerPortraitR.position.y = 490
			$SpeakerPortraitL.position.y = 530
	elif (previousSpeakerSide == "RIGHT" and swap) or (previousSpeakerSide == "LEFT" and not swap):
		previousSpeakerSide = "LEFT"
		speakerPortrait = $SpeakerPortraitL
		speakerPortrait.flip_h = false
		speaker = $SpeakerL
		speakerName = $SpeakerL/BG/Name
		if $SpeakerPortraitL.position.y != 490:
			$SpeakerPortraitL.position.y = 490
			$SpeakerPortraitR.position.y = 530

	speakerPortrait.set_texture(portrait)
	$Speech/BG/Text.visible_characters = 0
	$Speech/BG/Text.text = dialogue.message
	speaker.visible = true
	speakerPortrait.visible = true
	speakerName.text = "[center]" + dialogue.speaker + "[/center]"


func displayNextMessage(overrideDialogue):
	var dialogue = overrideDialogue if overrideDialogue else dialogues[dialogueIndex]

	if dialogue.has("transition"):
		fadeout.emit()
		dialogueIndex += 1
		return
	
	if $TypeTimer.is_stopped():
		$TypeTimer.start()

	if dialogue.speaker == "narrator": 
		narrate(dialogue.message)
		return

	var portrait = load("res://Assets/" + dialogue.portrait + ".png")

	if previousSpeaker == null:
		previousSpeaker = dialogue.speaker
		previousSpeakerSide = "RIGHT"

	if dialogue.speaker == previousSpeaker:
		setSpeaker(false, dialogue, portrait)
	else:
		setSpeaker(true, dialogue, portrait)

	previousSpeaker = dialogue.speaker

func togglePrompts():
	for prompt in [$Prompt1, $Prompt2, $Prompt3, $Prompt4]:
		prompt.visible = not prompt.visible
		prompt.disabled = not prompt.disabled


func displayPrompt(prompts):
	shownPrompts.push_back(dialogueIndex) # save reference to prompt @ index so we dont double-show it
	$Prompt1.text = prompts[0]
	$Prompt2.text = prompts[1]
	$Prompt3.text = prompts[2]
	$Prompt4.text = prompts[3]
	
	#Re-sizing prompt texture to fit different sizes of text. Real god level coding right here.
	for x in prompts.size():
		var promptnum = get_node("Prompt" + str(x+1))
		if prompts[x].length() < 55: 
			promptnum.icon = load("res://Assets/PromptLength1.png")
		if prompts[x].length() >= 55: 
			promptnum.icon = load("res://Assets/promptlength2.png")
		if prompts[x].length() >= 65: 
			promptnum.icon = load("res://Assets/promptlength3.png")
		if prompts[x].length() >= 75: 
			promptnum.icon = load("res://Assets/promptlength4.png")
		if prompts[x].length() >= 85: 
			promptnum.icon = load("res://Assets/promptlength5.png")
		if prompts[x].length() >= 100: 
			promptnum.icon = load("res://Assets/promptlength6.png")

	togglePrompts()
	usecontroller = false


func advanceMessage():
	if dialogueIndex == dialogues.size() - 1:
		print("ending convo")
		end.emit()
	else:
		dialogueIndex += 1
		displayNextMessage(null)
		$Boop.play()

func updateState(update: Dictionary):
	var princess = State.Princess[update.princess]
	var category = State.Category[update.category]
	State.set_state(princess, category)

func _process(_delta):
	if animating:
		return

	if not awaitingPrompt and Input.is_action_just_pressed("text_advance"):
		if isFinishedTyping():
			advanceMessage()
			$EndOfMessagePrompt.visible = false
		else:
			$Speech/BG/Text.visible_characters = $Speech/BG/Text.text.length()
			
	if Input.is_action_just_pressed("menu_focus") && usecontroller == false && $Prompt1.visible == true :
		$Prompt1.grab_focus()
		usecontroller = true
		
	if Input.is_action_just_pressed("controller_detect") && State.activecontroller == false :
		State.activecontroller = true
		
	if Input.is_action_just_pressed("keyboard_mouse_detect") && State.activecontroller == true :
		State.activecontroller = false
		
	if State.activecontroller == true :
		$"Pause Prompt".texture = load("res://Assets/Pause Start Prompt.png")

	if State.activecontroller == false :
		$"Pause Prompt".texture = load("res://Assets/Pause Prompt.png")


func _on_type_timer_timeout():
	if not isFinishedTyping():
		$Speech/BG/Text.visible_characters += 1
	else:
		$TypeTimer.stop()
		$EndOfMessagePrompt.visible = true
		if dialogues[dialogueIndex].has("prompts") and shownPrompts.find(dialogueIndex) == -1:
			awaitingPrompt = true
			displayPrompt(dialogues[dialogueIndex].prompts)


# TODO: update state if callback represents correct answer linking prince + princess
func _on_prompt_1_pressed():
	awaitingPrompt = false
	togglePrompts()
	if not dialogues[dialogueIndex].updates[0] == null:
		updateState(dialogues[dialogueIndex].updates[0])
	displayNextMessage(dialogues[dialogueIndex].responses[0])


func _on_prompt_2_pressed():
	awaitingPrompt = false
	togglePrompts()
	if not dialogues[dialogueIndex].updates[1] == null:
		updateState(dialogues[dialogueIndex].updates[1])
	displayNextMessage(dialogues[dialogueIndex].responses[1])


func _on_prompt_3_pressed():
	awaitingPrompt = false
	togglePrompts()
	if not dialogues[dialogueIndex].updates[2] == null:
		updateState(dialogues[dialogueIndex].updates[2])
	displayNextMessage(dialogues[dialogueIndex].responses[2])


func _on_prompt_4_pressed():
	awaitingPrompt = false
	togglePrompts()
	if not dialogues[dialogueIndex].updates[3] == null:
		updateState(dialogues[dialogueIndex].updates[3])
	displayNextMessage(dialogues[dialogueIndex].responses[3])
