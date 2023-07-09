extends TextureRect


var dialogues = null


func _ready():
	var json = JSON.new()
	var file = FileAccess.open("res://Dialogue/dating_phase_2.json", FileAccess.READ)
	var content = file.get_as_text()
	var error = json.parse(content)

	if error == OK:
		dialogues = json.data
		$Conversation.setup(dialogues)
