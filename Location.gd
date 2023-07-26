extends Control

var usecontroller = false

func _ready():
	$FadeIn.play("fade_in")
	$BGAnimation.play("BG_Movement")
	
func _process(_delta):
	if Input.is_action_just_pressed("menu_focus") && usecontroller == false && $Dossier.visible == false :
		usecontroller = true
		$DossierButton.grab_focus()
		
	if Input.is_action_just_pressed("menu_focus") && usecontroller == false && $Dossier.visible == true :
		usecontroller = true
		$"Dossier/Dossier Back".grab_focus()

func _on_battlefield_button_pressed():
	$SelectionUIAudio.play()
	$FadeOut.play("fade_out")
	await get_tree().create_timer(2).timeout

	State.set_target_princess(State.Princess.Sienna)
	if State.get_ending(State.Princess.Sienna) == State.Ending.War:
		get_tree().change_scene_to_file("res://EndingBadWar.tscn")
	else:
		get_tree().change_scene_to_file("res://EndingBadWedding.tscn")


func _on_stable_button_pressed():
	$SelectionUIAudio.play()
	$FadeOut.play("fade_out")
	await get_tree().create_timer(2).timeout

	State.set_target_princess(State.Princess.Wilhelmina)
	if State.get_ending(State.Princess.Wilhelmina) == State.Ending.War:
		get_tree().change_scene_to_file("res://EndingBadWar.tscn")
	else:
		get_tree().change_scene_to_file("res://EndingBadWedding.tscn")


func _on_meadow_button_pressed():
	$SelectionUIAudio.play()
	$FadeOut.play("fade_out")
	await get_tree().create_timer(2).timeout

	State.set_target_princess(State.Princess.Chessa)
	if State.get_ending(State.Princess.Chessa) == State.Ending.Good:
		get_tree().change_scene_to_file("res://EndingGood.tscn")
	else:
		get_tree().change_scene_to_file("res://EndingBadWedding.tscn")
		
		



func _on_battlefield_button_mouse_entered():
	$HoverUIAudio.play()
	usecontroller = false


func _on_stable_button_mouse_entered():
	$HoverUIAudio.play()
	usecontroller = false


func _on_meadow_button_mouse_entered():
	$HoverUIAudio.play()
	usecontroller = false
	
	
	

func _on_dossier_button_pressed():
	get_tree().paused = true
	$Dossier.visible = true
	$"Dossier/Dossier Back".grab_focus()
	usecontroller = false
	
func _on_dossier_button_mouse_entered():
	$DossierButton.icon = load("res://Assets/Check Dossier Button Highlighted.png")
	$HoverUIAudio.play()
	usecontroller = false

func _on_dossier_button_mouse_exited():
	$DossierButton.icon = load("res://Assets/Check Dossier Button.png")
	usecontroller = false
	
func _on_dossier_button_focus_entered():
	$DossierButton.icon = load("res://Assets/Check Dossier Button Highlighted.png")
	$HoverUIAudio.play()


func _on_dossier_button_focus_exited():
	$DossierButton.icon = load("res://Assets/Check Dossier Button.png")
	


func _on_dossier_back_pressed():
	$Dossier.visible = false
	get_tree().paused = false
	usecontroller = false


func _on_dossier_back_mouse_entered():
	$"Dossier/Dossier Back".icon = load("res://Assets/Back Button Highlighted.png")
	$"HoverUIAudio".play()
	usecontroller = false

func _on_dossier_back_mouse_exited():   
	$"Dossier/Dossier Back".icon = load("res://Assets/Back Button.png")
	usecontroller = false

func _on_dossier_back_focus_entered():
	$"Dossier/Dossier Back".icon = load("res://Assets/Back Button Highlighted.png") 
	$"HoverUIAudio".play()


func _on_dossier_back_focus_exited():
	$"Dossier/Dossier Back".icon = load("res://Assets/Back Button.png")

