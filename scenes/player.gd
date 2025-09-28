extends CharacterBody2D

@onready var _animated_sprite = $PlayerSprite

# Movement speed
var speed := 200.0

func _physics_process(delta):
	var direction = Vector2.ZERO

	# Movement input (arrow keys or WASD)
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		direction.x += 1
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		direction.y += 1
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		direction.y -= 1

	# Apply velocity
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO

	# Move and collide (this stops at walls/boxes)
	move_and_slide()

	# Animation handling
	if direction.x > 0:  # Moving right
		_animated_sprite.play("Run")
	elif direction.x < 0:  # Moving left
		_animated_sprite.play("runback")
	elif direction.y != 0:  # Moving up/down
		_animated_sprite.play("Run")
	else:
		_animated_sprite.play("Idle")
