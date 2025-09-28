extends ProgressBar

func update_bar():
	self.value = Globals.sanity
	
func _ready():
	Globals.connect("sanity_changed", update_bar)

func _process(delta: float) -> void:
	value = Globals.get_sanity()

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://scenes/MainGame.tscn")
