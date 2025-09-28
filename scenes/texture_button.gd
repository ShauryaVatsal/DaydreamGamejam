extends TextureButton

@onready var paper = $"../Paper"
var open = false

func _ready():
	pressed.connect(_button_pressed)
	

func _button_pressed():
	open = not open
	if open:
		open_letter()
	else:
		close_letter()
	

func open_letter():
	var tween = get_tree().create_tween()
	tween.tween_property(paper, "position", Vector2(574, 309), 1).set_trans(Tween.TRANS_SINE)
	
func close_letter():
	var tween = get_tree().create_tween()
	tween.tween_property(paper, "position", Vector2(574, 1005), 1).set_trans(Tween.TRANS_SINE)
