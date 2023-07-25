extends Control

#false = mouse/keyboard. true = controller
var usecontroller = false 

func _ready():
	$FadeIn.play("Fade_In")
	$TitleFloat.play("Title_Float")
		
func _process(_delta):		
	if Input.is_action_just_pressed("menu_focus") && usecontroller == false :
		usecontroller = true
		$MouseHoverAudio.play()
		$BG/Play.grab_focus()

func _on_play_pressed():	
	var ratset = FileAccess.open("user://ratdossier.txt", FileAccess.WRITE)
	var ratsettext = "Enter notes about Chessa here."
	ratset.store_string(ratsettext)
	
	var mantisset = FileAccess.open("user://mantisdossier.txt", FileAccess.WRITE)
	var mantissettext = "Enter notes about Sienna here."
	mantisset.store_string(mantissettext)
	
	var horseset = FileAccess.open("user://horsedossier.txt", FileAccess.WRITE)
	var horsesettext = "Enter notes about Wilhelmina here."
	horseset.store_string(horsesettext)
	
	var frogset = FileAccess.open("user://frogdossier.txt", FileAccess.WRITE)
	var frogsettext = "Enter notes about Gog here."
	frogset.store_string(frogsettext)
	
	$SelectUIAudio.play()
	$FadeOut.play("Fade_Out")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://DatingPhase1.tscn")
	
func _on_play_mouse_entered():
	$BG/Play.icon = load("res://Assets/Play Button Highlighted.png")
	$BG/Play.grab_focus()
	$MouseHoverAudio.play()
	usecontroller = false
	
func _on_play_mouse_exited():
	$BG/Play.icon = load("res://Assets/Play Button.png")
	usecontroller = false
	
func _on_play_focus_entered():
	$BG/Play.icon = load("res://Assets/Play Button Highlighted.png")

func _on_play_focus_exited():
	$BG/Play.icon = load("res://Assets/Play Button.png")
	
func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Credits.tscn")
	
func _on_credits_mouse_entered():
	$BG/Credits.icon = load("res://Assets/Credits Button Highlighted.png")
	$BG/Credits.grab_focus()
	$MouseHoverAudio.play()
	usecontroller = false
	
func _on_credits_mouse_exited():
	$BG/Credits.icon = load("res://Assets/Credits Button.png")
	usecontroller = false
	
func _on_credits_focus_entered():
	$BG/Credits.icon = load("res://Assets/Credits Button Highlighted.png")

func _on_credits_focus_exited():
	$BG/Credits.icon = load("res://Assets/Credits Button.png")
	
func _on_exit_pressed():
	$SelectUIAudio.play()
	$FadeOut.play("Fade_Out")
	await get_tree().create_timer(2).timeout
	get_tree().quit()
	
func _on_exit_mouse_entered():
	$BG/Exit.icon = load("res://Assets/Exit Button Highlighted.png")
	$BG/Exit.grab_focus()
	$MouseHoverAudio.play()
	usecontroller = false
	
func _on_exit_mouse_exited():
	$BG/Exit.icon = load("res://Assets/Exit Button.png")
	usecontroller = false
	
func _on_exit_focus_entered():
	$BG/Exit.icon = load("res://Assets/Exit Button Highlighted.png")
	$MouseHoverAudio.play()

func _on_exit_focus_exited():
	$BG/Exit.icon = load("res://Assets/Exit Button.png")

func _on_title_float_animation_finished(_anim_name):
	$TitleFloat.play("Title_Float")

