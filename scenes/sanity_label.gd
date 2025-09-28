extends Label

func _process(delta: float) -> void:
	text = "Sanity " + str(Globals.get_sanity())
