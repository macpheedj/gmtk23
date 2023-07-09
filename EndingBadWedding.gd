extends Node2D


var dialogues = null
var canExit = false
var debounce = false


func _ready():
	var json = JSON.new()
	var file = FileAccess.open("res://Dialogue/ending_2.json", FileAccess.READ)
	var content = file.get_as_text()
	var error = json.parse(content)

	if error == OK:
		dialogues = json.data
		$Conversation.end.connect(_on_conversation_end)
		$Conversation.fadeout.connect(_on_conversation_fadeout)
		$Conversation.setup(dialogues)
		$FadeIn.play("FadeIn")
		await get_tree().create_timer(1).timeout


func _process(_delta):
	if canExit and Input.is_action_just_pressed("text_advance"):
		$FadeOut.play("FadeOut")
		await get_tree().create_timer(1).timeout
		$Music.stop()
		get_tree().quit()


func _on_conversation_fadeout():
	$Conversation.setAnimating(true)
	$FadeOut.play("FadeOut")
	await get_tree().create_timer(1).timeout
	$Conversation.displayNextMessage(null)
	$FadeIn.play("FadeIn")
	await get_tree().create_timer(1).timeout
	$Conversation.setAnimating(false)
	pass


func _on_conversation_end():
	if not debounce:
		debounce = true
		$Music.play()
		await get_tree().create_timer(5).timeout
		canExit = true
