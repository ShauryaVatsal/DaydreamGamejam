extends Button

func _ready() -> void:
	pressed.connect(play)

func play():
	get_tree().change_scene_to_file("res://scenes/hell.tscn")
	Globals.turnplace(true)
