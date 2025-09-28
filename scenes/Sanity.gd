extends ProgressBar

func update_bar():
	self.value = Globals.sanity
	
func _ready():
	Globals.connect("sanity_changed", update_bar())
