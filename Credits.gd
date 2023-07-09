extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$MainTheme.play()
	$ScrollAction.play("Text_Scroll")
	await get_tree().create_timer(38).timeout
	$MainTheme.play()
	await get_tree().create_timer(38).timeout
	get_tree().quit()
