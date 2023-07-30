extends Node2D


var dialogues = null
var canExit = false
var debounce = false


func inject_wrongful_princess(text: String) -> String:
	var princess_name = State.get_target_princess().name
	var princess_expression = State.get_target_princess().name.to_lower()

	return text.replace("TARGET_PRINCESS_NAME", princess_name).replace("TARGET_PRINCESS_EXPRESSION", princess_expression)

func set_background():
	var princess = State.get_target_princess().id
	var princess_map = {
		State.Princess.Sienna: {
			background = "res://Assets/castle_background.png",
			scale = Vector2(1, 1),
		},
		State.Princess.Wilhelmina: {
			background = "res://Assets/stable_background.png",
			scale = Vector2(4, 4),
		},
	}
	var background_path = princess_map[princess].background
	var background = load(background_path)
	$Background.set_texture(background)
	$Background.set_scale(princess_map[princess].scale)


func _ready():
	var json = JSON.new()
	var file = FileAccess.open("res://Dialogue/ending_1.json", FileAccess.READ)
	var text = file.get_as_text()
	var content = inject_wrongful_princess(text)
	var error = json.parse(content)

	if error == OK:
		dialogues = json.data
		$Conversation.end.connect(_on_conversation_end)
		$Conversation.fadeout.connect(_on_conversation_fadeout)
		$Conversation.setup(dialogues)
		set_background()
		$FadeIn.play("FadeIn")
		await get_tree().create_timer(1).timeout


func _process(_delta):
	if canExit and Input.is_action_just_pressed("text_advance"):
		$FadeOut.play("FadeOut")
		await get_tree().create_timer(1).timeout
		$Music.stop()
		get_tree().change_scene_to_file("res://Credits.tscn")

	if Input.is_action_just_pressed("pause"): pass


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
