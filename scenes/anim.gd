extends Node

@onready var MC = $MC
@onready var MC_label = $MC/Label
@onready var Devil = $Devil
@onready var Devil_label = $Devil/Label

func make_one_talk(text, duration):
	MC.play("Talk")
	$Timer.start(duration)
	MC_label.text = text
	await $Timer.timeout
	MC.stop()
	MC_label.text = ""
	
func make_two_talk(text, duration):
	Devil.play("default")
	$Timer.start(duration)
	Devil_label.text = text
	await $Timer.timeout
	Devil.stop()
	Devil_label.text = ""
	
func foo():
	$Button.visible = false
	make_two_talk("Welcome to hell!", 4)
	$Timer.start(4)
	await $Timer.timeout
	make_one_talk("How do I go back?", 4)
	$Timer.start(4)
	await $Timer.timeout
	make_two_talk("Find out your killer by going to the real world and finding clues", 4)
	$Timer.start(4)
	await $Timer.timeout
	make_two_talk("Be careful! You might go insane.", 4)
	$Timer.start(4)
	await $Timer.timeout
	get_tree().change_scene_to_file("res://scenes/hell.tscn")

func _ready():
	$Button.pressed.connect(foo)
