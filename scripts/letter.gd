extends TextureRect

@onready var envelope = get_node("Interactables/Sprite2D")
var open = false
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
