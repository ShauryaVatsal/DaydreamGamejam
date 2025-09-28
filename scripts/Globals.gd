extends Node

var sanity = 0
var game_state = "playing"
signal sanity_changed(amount)

func set_sanity(amount):
	sanity = amount
	sanity_changed.emit(sanity)
	
func get_sanity():
	return sanity
