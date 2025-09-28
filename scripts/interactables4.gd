extends Node

@onready var pills = $Pills
@onready var letter = $Letter

func _ready():
		pills.pressed.connect(letter._on_button_pressed) 
