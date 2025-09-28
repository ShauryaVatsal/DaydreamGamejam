extends Node2D

@onready var Room1 = $Room1Door
@onready var Room2 = $Room2Door
@onready var Room3 = $Room3Door
@onready var Room4 = $Room4Door

func tpRoom(roomnum):
	match  roomnum:
		1:	
			get_tree().change_scene_to_file("res://scenes/LivingRoom.tscn")
		2:
			get_tree().change_scene_to_file("res://scenes/KidRoom1.tscn")
		3:
			get_tree().change_scene_to_file("res://scenes/Basement.tscn")
		4:
			get_tree().change_scene_to_file("res://scenes/Pat.tscn")
			
func enterRoom1(body: Node2D):
	if body == $"../Player":
		print("room1 entered")
		tpRoom(1)
		
func enterRoom2(body: Node2D):
	if body == $"../Player":
		print("room2 entered")
		tpRoom(2)
		
func enterRoom3(body: Node2D):
	if body == $"../Player":
		print("room3 entered")
		tpRoom(3)
		
func enterRoom4(body: Node2D):
	if body == $"../Player":
		print("room4 entered")
		tpRoom(4)
		
func _ready():
	Room1.body_entered.connect(enterRoom1)
	Room2.body_entered.connect(enterRoom2)
	Room3.body_entered.connect(enterRoom3)
	Room4.body_entered.connect(enterRoom4)
	
