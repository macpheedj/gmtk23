extends Control

func _ready():
	$FadeIn.play("Fade_In")
	$TitleFloat.play("Title_Float")

func _on_play_pressed():
	var sceneset = FileAccess.open("user://activescene.txt", FileAccess.WRITE)
	var scenesettext = "res://DatingPhase1.tscn"
	sceneset.store_string(scenesettext)
	
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
	$MouseHoverAudio.play()
	
	
func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Credits.tscn")
	
func _on_credits_mouse_entered():
	$MouseHoverAudio.play()
	
	
func _on_exit_pressed():
	$SelectUIAudio.play()
	$FadeOut.play("Fade_Out")
	await get_tree().create_timer(2).timeout
	get_tree().quit()
	
func _on_exit_mouse_entered():
	$MouseHoverAudio.play()


func _on_title_float_animation_finished(_anim_name):
	$TitleFloat.play("Title_Float")












