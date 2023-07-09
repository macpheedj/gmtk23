extends TextureRect


var dialogues = null


func _ready():
	var json = JSON.new()
	var file = FileAccess.open("res://Dialogue/dating_phase_1.json", FileAccess.READ)
	var content = file.get_as_text()
	var error = json.parse(content)

	if error == OK:
		dialogues = json.data
		$Conversation.setup(dialogues)


# func _process(_delta):
# 	if Input.is_action_just_pressed("text_advance"):
# 		$Conversation.visible = true
# 		$Conversation.setup(dialogues)
