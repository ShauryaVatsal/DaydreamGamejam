extends AnimatedSprite2D

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		play("run")
	elif Input.is_action_pressed("ui_left"):
		play("run_back")
	else:
		stop()
