extends Node

@onready var envelope = $Envelope
@onready var bracelet = $bracelet
@onready var letter = $Letter
@onready var newletter = $newLetter

func _ready():
	envelope.pressed.connect(letter._on_button_pressed)
	bracelet.pressed.connect(newletter._on_button_pressed)
	

func _on_backtohall_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainGame.tscn")
	
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://scenes/MainGame.tscn")


func _on_texture_button_pressed() -> void:
	pass # Replace with function body.
