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


func _on_rat_profile_mouse_entered():
	$SelectUISound.play()


func _on_horse_profile_mouse_entered():
	$SelectUISound.play()


func _on_mantis_profile_mouse_entered():
	$SelectUISound.play()


func _on_frog_profile_mouse_entered():
	$SelectUISound.play()


func _on_back_button_pressed():
	var previousscene = FileAccess.open("user://activescene.txt",FileAccess.READ)
	var storepath = previousscene.get_as_text()
	
	var ratfile = FileAccess.open("user://ratdossier.txt", FileAccess.WRITE)
	ratfile.store_string($RatNotes.text)
	
	var mantisfile = FileAccess.open("user://mantisdossier.txt", FileAccess.WRITE)
	mantisfile.store_string($MantisNotes.text)
	
	var horsefile = FileAccess.open("user://horsedossier.txt", FileAccess.WRITE)
	horsefile.store_string($HorseNotes.text)
	
	var frogfile = FileAccess.open("user://frogdossier.txt", FileAccess.WRITE)
	frogfile.store_string($FrogNotes.text)
	
	$BackUISound.play()
	get_tree().change_scene_to_file(storepath)



