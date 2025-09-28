extends Node

@onready var knife = $Knife
@onready var letter = $Letter

func _ready():
		knife.pressed.connect(letter._on_button_pressed) 
