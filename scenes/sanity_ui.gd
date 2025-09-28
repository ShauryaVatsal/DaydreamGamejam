extends CanvasModulate

func _ready():
	Globals.sanity_changed.connect(update_ui)

func update_ui():
	self.color = Color(
	 int(Globals.get_sanity()*(255/200)),
	 int(Globals.get_sanity()*(255/100)),
	 int(Globals.get_sanity()*(255/100))
	)
	
