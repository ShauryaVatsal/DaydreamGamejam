extends ProgressBar
	
func _ready():
	Globals.sanity_changed.connect(update_bar)

func update_bar():
	self.value = Globals.sanity
