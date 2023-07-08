extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$BGAnimation.play("BG_Movement")
	
func _on_bg_animation_animation_finished(_anim_name):
	$BGAnimation.play("BG_Movement")


func _on_battlefield_button_pressed():
	$SelectUIAudio.play()


func _on_stable_button_pressed():
	$SelectUIAudio.play()


func _on_meadow_button_pressed():
	$SelectUIAudio.play()


func _on_pc_location_button_pressed():
	$SelectUIAudio.play()


func _on_button_pressed():
	$SelectUIAudio.play()
