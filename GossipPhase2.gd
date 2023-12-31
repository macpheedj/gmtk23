extends Node2D


var dialogues = null


func _ready():
	var json = JSON.new()
	var file = FileAccess.open("res://Dialogue/gossip_phase_2.json", FileAccess.READ)
	var content = file.get_as_text()
	var error = json.parse(content)
	$PauseMenu/PauseMenuBG.visible = false

	if error == OK:
		dialogues = json.data
		$Conversation.end.connect(_on_conversation_end)
		$Conversation.fadeout.connect(_on_conversation_fadeout)
		$Conversation.setup(dialogues)
		$FadeIn.play("FadeIn")
		await get_tree().create_timer(1).timeout
		
func _process(_delta):
	if Input.is_action_just_pressed("pause") && $PauseMenu/PauseMenuBG.visible == false :      
		$PauseMenu/PauseMenuBG.visible = true
		$PauseMenu/PauseMenuOpening.play("pause_expand")
		await get_tree().create_timer(0.2).timeout
		get_tree().paused = true
	
func _on_dossier_pressed():
	$Dossier.visible = true
	
func _on_back_pressed():
	get_tree().paused = false
	$PauseMenuClosing.play("pause_contract")
	await get_tree().create_timer(0.2).timeout
	$PauseMenu.visible = false      

func _on_quit_pressed():
	get_tree().quit()
	
func _on_dossier_back_pressed():
	$Dossier.visible = false    


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
	get_tree().change_scene_to_file("res://DatingPhase3.tscn")
	
func _on_dossier_mouse_entered():
	$PauseMenu/Dossier.icon = load("res://Assets/Dossier Button Highlighted.png")

func _on_dossier_mouse_exited():
	$PauseMenu/Dossier.icon = load("res://Assets/Dossier Button.png")    	
	
func _on_back_mouse_entered():
	$PauseMenu/Back.icon = load("res://Assets/Back Button Highlighted.png")

func _on_back_mouse_exited():
	$PauseMenu/Back.icon = load("res://Assets/Back Button.png")
	
func _on_quit_mouse_entered():
	$PauseMenu/Quit.icon = load("res://Assets/Quit Button Highlighted.png")

func _on_quit_mouse_exited():
	$PauseMenu/Quit.icon = load("res://Assets/Quit Button.png")


func _on_dossier_back_mouse_entered():
	$"Dossier/Dossier Back".icon = load("res://Assets/Back Button Highlighted.png") 
	$"Dossier/Dossier Back/HoverAudio".play()

func _on_dossier_back_mouse_exited():   
	$"Dossier/Dossier Back".icon = load("res://Assets/Back Button.png")
