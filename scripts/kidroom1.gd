extends Node2D

# Kidroom1 scene script - handles button press functionality

@onready var button = $Button  # Assuming the button is named "Button"

func _ready():
	# Connect the button signal
	if button:
		button.pressed.connect(_on_button_pressed)
		print("Button connected successfully")
	else:
		print("Button not found!")

func _on_button_pressed():
	print("Button was pressed!")
	# Add your button functionality here
	# For example:
	# - Change scene
	# - Show/hide something
	# - Play sound
	# - etc.
