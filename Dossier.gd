extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$FadeIn.play("Fade_In")
	var ratfile = FileAccess.open("user://ratdossier.txt", FileAccess.READ)
	$RatNotes.text = ratfile.get_as_text()
	var mantisfile = FileAccess.open("user://mantisdossier.txt", FileAccess.READ)
	$MantisNotes.text = mantisfile.get_as_text()
	var horsefile = FileAccess.open("user://horsedossier.txt", FileAccess.READ)
	$HorseNotes.text = horsefile.get_as_text()
	var frogfile = FileAccess.open("user://frogdossier.txt", FileAccess.READ)
	$FrogNotes.text = frogfile.get_as_text()
	$BGAnimation.play("BG_Movement")

func _on_dossier_back_pressed():
	var ratfile = FileAccess.open("user://ratdossier.txt", FileAccess.WRITE)
	ratfile.store_string($RatNotes.text)
	
	var mantisfile = FileAccess.open("user://mantisdossier.txt", FileAccess.WRITE)
	mantisfile.store_string($MantisNotes.text)
	
	var horsefile = FileAccess.open("user://horsedossier.txt", FileAccess.WRITE)
	horsefile.store_string($HorseNotes.text)
	
	var frogfile = FileAccess.open("user://frogdossier.txt", FileAccess.WRITE)
	frogfile.store_string($FrogNotes.text)
	
	$BackUISound.play()

func _on_rat_profile_mouse_entered():
	$RatProfile.texture = load("res://Assets/chessa_blush.png")


func _on_rat_profile_mouse_exited():
	$RatProfile.texture = load("res://Assets/chessa_default.png")

func _on_mantis_profile_mouse_entered():
	$MantisProfile.texture = load("res://Assets/sienna_blush.png")

func _on_mantis_profile_mouse_exited():
	$MantisProfile.texture = load("res://Assets/sienna_default.png")
	
func _on_horse_profile_mouse_entered():
	$HorseProfile.texture = load("res://Assets/Horse_Blush.png")
	
func _on_horse_profile_mouse_exited():
	$HorseProfile.texture = load("res://Assets/Horse_Normal.png")
	
func _on_frog_profile_mouse_entered():
	$FrogProfile.texture = load("res://Assets/gog_blush.png")

func _on_frog_profile_mouse_exited():
	$FrogProfile.texture = load("res://Assets/gog_default.png")

func _on_bg_animation_animation_finished(_anim_name):
	$BGAnimation.play("BG_Movement")
