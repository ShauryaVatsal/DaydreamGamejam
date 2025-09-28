extends Node

@onready var envelope = $Envelope
@onready var letter = $Letter

func _ready():
		envelope.pressed.connect(letter._on_button_pressed) 
