extends Node

var sanity = 0
var inHell = true

func _ready() -> void:
	set_sanity(100)
	

func set_sanity(amount):
	sanity = amount

func get_sanity():
	return sanity

func turnplace(boo):
	inHell = boo

func _process(delta: float) -> void:
	if not inHell:
		set_sanity(get_sanity() - delta*3)
		if get_sanity() <= 0:
			get_tree().change_scene_to_file("res://scenes/endgame scene.tscn")
			inHell = true
