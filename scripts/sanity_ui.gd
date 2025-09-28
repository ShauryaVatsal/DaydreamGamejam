extends CanvasModulate

func _process(delta):
	self.color = Color(
	 int(Globals.get_sanity()*(255/200)),
	 int(Globals.get_sanity()*(255/100)),
	 int(Globals.get_sanity()*(255/100))
	)
	
