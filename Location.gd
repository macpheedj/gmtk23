extends Node2D

func _ready():
	$FadeIn.play("FadeIn")

func _on_battlefield_button_pressed():
	$SelectionUIAudio.play()
	#$FadeOut.play("Fade_Out")
	#await get_tree().create_timer(2).timeout
	#get_tree().change_scene_to_file("res://mainmenu.tscn")
	


func _on_stable_button_pressed():
	$SelectionUIAudio.play()
	#$FadeOut.play("Fade_Out")
	#await get_tree().create_timer(2).timeout
	#get_tree().change_scene_to_file("res://mainmenu.tscn")


func _on_meadow_button_pressed():
	$SelectionUIAudio.play()
	#$FadeOut.play("Fade_Out")
	#await get_tree().create_timer(2).timeout
	#get_tree().change_scene_to_file("res://mainmenu.tscn")


func _on_battlefield_button_mouse_entered():
	$HoverUIAudio.play()


func _on_stable_button_mouse_entered():
	$HoverUIAudio.play()


func _on_meadow_button_mouse_entered():
	$HoverUIAudio.play()
