extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$MainTheme.play()
	$ScrollAction.play("Text_Scroll")
