extends Area2D


func _on_room_3_area_body_entered(body: Node2D) -> void:
	if body == $"../../../Player":
		get_tree().change_scene_to_file("res://scenes/Basement.tscn")

func _on_room_4_door_body_entered(body: Node2D) -> void:
	if body == $"../../../Player":
		get_tree().change_scene_to_file("res://scenes/Pat.tscn")
		
func _on_body_entered(body: Node2D) -> void:
	if body == $"../../../Player":
		get_tree().change_scene_to_file("res://scenes/KidRoom1.tscn")
	
