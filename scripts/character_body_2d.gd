extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

func _process(_delta):

	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	if Input.is_action_pressed("Right"):
		_animated_sprite.play("run")
	elif Input.is_action_pressed("Left"):
		_animated_sprite.play("run_back")
	else:
		_animated_sprite.stop()

func _physics_process(delta: float) -> void:
	var speed = 500
	var player_velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("Right"):
		player_velocity.x += 1
	if Input.is_action_pressed("Left"):
		player_velocity.x -= 1
	if Input.is_action_pressed("Down"):
		player_velocity.y += 1
	if Input.is_action_pressed("Jump"):
		player_velocity.y -= 1
	
	velocity = player_velocity.normalized() * speed
	move_and_slide()
