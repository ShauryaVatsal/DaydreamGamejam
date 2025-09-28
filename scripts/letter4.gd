extends TextureRect

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://scenes/MainGame.tscn")

@onready var close_button = $CloseButton

var open = false

func _ready() -> void:
	close_button.pressed.connect(_on_button_pressed)

func open_letter():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(175, 50), 1).set_trans(Tween.TRANS_SINE)
	
	
func close_letter():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(175, 800), 1).set_trans(Tween.TRANS_SINE)
	
func _on_button_pressed():
	open = not open
	if open:
		open_letter()
	else:
		close_letter()
