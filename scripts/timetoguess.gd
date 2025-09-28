extends Node2D

@onready var correct = $correct
@onready var wrong = $wrong
@onready var wrong2 = $wrong2

func _ready():
	correct.pressed.connect(_on_correct_pressed)
	wrong.pressed.connect(_on_wrong_pressed)
	wrong2.pressed.connect(_on_wrong_pressed)


func _input2(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://scenes/MainGame.tscn")


func _on_wrong_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dead.tscn")


func _on_correct_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/winner.tscn")


func _on_wrong_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dead.tscn")
