extends TextureButton

@onready var label = $"../Label"

func _ready():
	pressed.connect(_button_pressed)
	

func _button_pressed():
	label.visible = true
	$"../Paper".visible = true
