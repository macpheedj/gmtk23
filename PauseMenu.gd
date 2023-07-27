extends Control

#false = mouse/keyboard. true = controller
var usecontroller = false 

func _process(_delta):
	if Input.is_action_just_pressed("menu_focus") && usecontroller == false && $Dossier.visible == false :
		usecontroller = true
		$PauseMenuBG/Dossier.grab_focus()
		
	if Input.is_action_just_pressed("menu_focus") && usecontroller == false && $Dossier.visible == true :
		usecontroller = true
		$"Dossier/Dossier Back".grab_focus()
		
	if Input.is_action_just_pressed("Cancel") :
		$"SelectUIAudio".play()
		await get_tree().create_timer(0.1).timeout  
		$PauseMenuClosing.play("pause_contract")
		usecontroller = false
		await get_tree().create_timer(0.4).timeout  
		get_tree().paused = false
		$PauseMenuBG.visible = false
		
func _on_dossier_pressed():  
	$"SelectUIAudio".play()    
	$Dossier.visible = true
	usecontroller = false
	
func _on_dossier_mouse_entered():
	$PauseMenuBG/Dossier.icon = load("res://Assets/Dossier Button Highlighted.png")
	$"HoverUIAudio".play()
	usecontroller = false

func _on_dossier_mouse_exited():
	$PauseMenuBG/Dossier.icon = load("res://Assets/Dossier Button.png")
	
func _on_dossier_focus_entered():
	$PauseMenuBG/Dossier.icon = load("res://Assets/Dossier Button Highlighted.png")
	$"HoverUIAudio".play()
	
func _on_dossier_focus_exited():
	$PauseMenuBG/Dossier.icon = load("res://Assets/Dossier Button.png")
	
func _on_back_pressed():
	$"SelectUIAudio".play()
	await get_tree().create_timer(0.1).timeout  
	$PauseMenuClosing.play("pause_contract")
	usecontroller = false
	await get_tree().create_timer(0.4).timeout  
	get_tree().paused = false
	$PauseMenuBG.visible = false
	
func _on_back_mouse_entered():
	$PauseMenuBG/Back.icon = load("res://Assets/Back Button Highlighted.png")
	$"HoverUIAudio".play()
	usecontroller = false

func _on_back_mouse_exited():
	$PauseMenuBG/Back.icon = load("res://Assets/Back Button.png")
	usecontroller = false
	
func _on_back_focus_entered():
	$PauseMenuBG/Back.icon = load("res://Assets/Back Button Highlighted.png")
	$"HoverUIAudio".play()

func _on_back_focus_exited():
	$PauseMenuBG/Back.icon = load("res://Assets/Back Button.png")

func _on_quit_pressed():
	get_tree().quit()  
	
func _on_quit_mouse_entered():
	$PauseMenuBG/Quit.icon = load("res://Assets/Quit Button Highlighted.png")
	$"HoverUIAudio".play()
	usecontroller = false

func _on_quit_mouse_exited():
	$PauseMenuBG/Quit.icon = load("res://Assets/Quit Button.png")
	usecontroller = false
	
func _on_quit_focus_entered():
	$PauseMenuBG/Quit.icon = load("res://Assets/Quit Button Highlighted.png")
	$"HoverUIAudio".play()

func _on_quit_focus_exited():
	$PauseMenuBG/Quit.icon = load("res://Assets/Quit Button.png")

func _on_dossier_back_pressed():
	$Dossier.visible = false
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
	usecontroller = false

func _on_dossier_back_focus_exited():
	$"Dossier/Dossier Back".icon = load("res://Assets/Back Button.png")
	usecontroller = false
