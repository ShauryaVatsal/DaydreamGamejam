extends CanvasModulate

func _process(delta):
	self.color = Color(
		0.5 + Globals.get_sanity()*(1.0/200.0),
		Globals.get_sanity()*(1.0/100.0),
		Globals.get_sanity()*(1.0/100.0)
	)
	print(self.color, Globals.get_sanity())
	
