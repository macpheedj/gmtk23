extends Control

func _ready():
	$FadeIn.play("Fade_In")
	$TitleFloat.play("Title_Float")

func _on_play_pressed():
	$SelectUIAudio.play()
	$FadeOut.play("Fade_Out")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://game.tscn")
	
	
func _on_exit_pressed():
	$SelectUIAudio.play()
	$FadeOut.play("Fade_Out")
	await get_tree().create_timer(2).timeout
	get_tree().quit()
	


func _on_title_float_animation_finished(_anim_name):
	$TitleFloat.play("Title_Float")
