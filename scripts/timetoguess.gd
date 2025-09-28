extends Node2D



func _on_wrong_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dead.tscn")


func _on_correct_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/winner.tscn")


func _on_wrong_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dead.tscn")
