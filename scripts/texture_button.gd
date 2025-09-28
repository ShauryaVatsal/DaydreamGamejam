extends TextureButton

@onready var paper = $"../Paper"
var open = false

func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
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


func _on_backtohall_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainGame.tscn")
