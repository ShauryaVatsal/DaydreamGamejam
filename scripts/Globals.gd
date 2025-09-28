extends Node

var sanity = 0
var inHell = true
signal sanity_changed(amount)

func _ready() -> void:
	set_sanity(100)
	
	

func set_sanity(amount):
	sanity = amount
	print("san changed")
	sanity_changed.emit(sanity)
	
func get_sanity():
	return sanity

func turnplace(boo):
	inHell = boo

func _process(delta: float) -> void:
	if not inHell:
		set_sanity(get_sanity() - delta)
		if get_sanity() <= 0:
			print("Game Lost")
