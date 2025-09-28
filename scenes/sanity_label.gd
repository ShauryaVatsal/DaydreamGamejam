extends Label

func _process(delta: float) -> void:
	text = "Sanity " + str(int(Globals.get_sanity()))
