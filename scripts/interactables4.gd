extends Node

@onready var pills = $Pills
@onready var cloth = $Cloth
@onready var letter = $Letter
@onready var letter2 = $Letter2

func _ready():
		pills.pressed.connect(letter._on_button_pressed) 
		cloth.pressed.connect(letter2._on_button_pressed)


func _on_backtohall_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainGame.tscn")
