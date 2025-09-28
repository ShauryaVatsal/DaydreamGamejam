extends Node

@onready var envelope = $Envelope
@onready var letter = $Letter

func _ready():
	envelope.pressed.connect(letter._on_button_pressed)

func _on_backtohall_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainGame.tscn")
