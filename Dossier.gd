extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$FadeIn.play("Fade_In")
	


func _on_rat_profile_mouse_entered():
	$SelectUISound.play()
	


func _on_horse_profile_mouse_entered():
	$SelectUISound.play()


func _on_mantis_profile_mouse_entered():
	$SelectUISound.play()


func _on_frog_profile_mouse_entered():
	$SelectUISound.play()


func _on_back_button_pressed():
	$BackUISound.play()
	get_tree().change_scene_to_file("res://mainmenu.tscn")
