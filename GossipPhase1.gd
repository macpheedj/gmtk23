extends Node2D


var dialogues = null


func _ready():
	var json = JSON.new()
	var file = FileAccess.open("res://Dialogue/gossip_phase_1.json", FileAccess.READ)
	var content = file.get_as_text()
	var error = json.parse(content)

	if error == OK:
		dialogues = json.data
		$Conversation.end.connect(_on_conversation_end)
		$Conversation.fadeout.connect(_on_conversation_fadeout)
		$Conversation.setup(dialogues)
		$FadeIn.play("FadeIn")
		await get_tree().create_timer(1).timeout
		
func _process(delta):
	if Input.is_action_just_pressed("exit") && $PauseMenu.visible == false : 
		$PauseMenu.visible = true
		get_tree().paused = true
		await get_tree().create_timer(0.5).timeout
		
	
func _on_dossier_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Dossier.tscn")
	
func _on_back_pressed():
	get_tree().paused = false
	$PauseMenu.visible = false      

func _on_quit_pressed():
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
	$FadeOut.play("FadeOut")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://DatingPhase2.tscn")
