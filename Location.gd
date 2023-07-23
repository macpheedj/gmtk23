extends Node2D

func _ready():
	$FadeIn.play("FadeIn")
	$BGAnimation.play("BG_Movement")
	
func _process(_delta):
	if Input.is_action_just_pressed("exit"): get_tree().quit()

func _on_battlefield_button_pressed():
	$SelectionUIAudio.play()
	$FadeOut.play("Fade_Out")
	await get_tree().create_timer(2).timeout
	if State.get_win_condition(State.Princess.Sienna):
		get_tree().change_scene_to_file("res://EndingBadWar.tscn")
	else:
		get_tree().change_scene_to_file("res://EndingBadWedding.tscn")


func _on_stable_button_pressed():
	$SelectionUIAudio.play()
	$FadeOut.play("Fade_Out")
	await get_tree().create_timer(2).timeout
	if State.get_win_condition(State.Princess.Wilhelmina):
		get_tree().change_scene_to_file("res://EndingBadWar.tscn")
	else:
		get_tree().change_scene_to_file("res://EndingBadWedding.tscn")


func _on_meadow_button_pressed():
	$SelectionUIAudio.play()
	$FadeOut.play("Fade_Out")
	await get_tree().create_timer(2).timeout
	if State.get_win_condition(State.Princess.Chessa):
		get_tree().change_scene_to_file("res://EndingGood.tscn")
	else:
		get_tree().change_scene_to_file("res://EndingBadWedding.tscn")


func _on_battlefield_button_mouse_entered():
	$HoverUIAudio.play()


func _on_stable_button_mouse_entered():
	$HoverUIAudio.play()


func _on_meadow_button_mouse_entered():
	$HoverUIAudio.play()

func _on_dossier_button_pressed():
	get_tree().paused = true
	$DossierMenu.visible = true
	
func _on_dossier_button_mouse_entered():
	$DossierButton.icon = load("res://Assets/Check Dossier Button Highlighted.png")
	$HoverUIAudio.play()

func _on_dossier_button_mouse_exited():
	$DossierButton.icon = load("res://Assets/Check Dossier Button.png")


func _on_back_button_pressed():
	get_tree().paused = false
	$DossierMenu.visible = false


func _on_dossier_back_pressed():
	$DossierMenu.visible = false
	get_tree().paused = false


func _on_dossier_back_mouse_entered():
	$"DossierMenu/Dossier Back".icon = load("res://Assets/Back Button Highlighted.png") 
	$"DossierMenu/Dossier Back/HoverAudio".play()

func _on_dossier_back_mouse_exited():   
	$"DossierMenu/Dossier Back".icon = load("res://Assets/Back Button.png")
