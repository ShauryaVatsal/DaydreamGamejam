extends Node2D

# Ghost Murder Mystery Game - Main Script
# Implements the core MVP loop with sanity system, clue collection, and win/lose conditions

# Game State Variables
var sanity = 100
var clues_found = []
const CLUES_NEEDED = 6  # Total clues needed to win
var current_room = "overworld"  # Current room: "overworld", "room1", "room2", "room3"
var game_ended = false

# UI References
@onready var sanity_label = $UI/SanityLabel
@onready var clue_label = $UI/ClueLabel
@onready var sanity_overlay = $UI/SanityOverlay
@onready var instructions = $UI/Instructions

# Room References
@onready var overworld = $Overworld
@onready var room1 = $Room1
@onready var room2 = $Room2
@onready var room3 = $Room3

# Player Reference
@onready var player = $Player
@onready var player_sprite = $Player/PlayerSprite

# Background boundaries
var background_position = Vector2(578.25006, 332)
var background_scale = Vector2(1.9102142, 1.6836983)
var background_original_size = Vector2(607, 411)
var background_scaled_size = background_original_size * background_scale
var background_bounds = Rect2(
	background_position.x - background_scaled_size.x / 2,
	background_position.y - background_scaled_size.y / 2,
	background_scaled_size.x,
	background_scaled_size.y
)

# Clue Data - Each clue has: name, text, and room
var clue_data = [
	{"name": "bloodstained_glove", "text": "You found a bloodstained glove! The victim was right-handed.", "room": "room1"},
	{"name": "broken_mirror", "text": "A broken mirror with a note: 'I saw everything...'", "room": "room1"},
	{"name": "poison_bottle", "text": "An empty poison bottle in the kitchen. The label is smudged.", "room": "room2"},
	{"name": "torn_letter", "text": "A torn letter: 'Meet me at midnight... it's the only way to...'", "room": "room2"},
	{"name": "secret_passage", "text": "You discovered a secret passage! Someone was hiding here.", "room": "room3"},
	{"name": "final_clue", "text": "A diary entry: 'The butler did it! I saw him with the poison!'", "room": "room3"}
]

func _ready():
	# Set up collision shapes
	setup_collision_shapes()
	
	# Connect door signals
	connect_door_signals()
	
	# Connect clue signals
	connect_clue_signals()
	
	# Initialize UI
	update_ui()
	
	# Start in overworld
	show_room("overworld")
	
	# Initial message
	show_clue_text("Welcome, ghost detective! Find all 6 clues to solve the murder mystery. Your sanity drains in the overworld...")

func setup_collision_shapes():
	# Player collision
	var player_shape = RectangleShape2D.new()
	player_shape.size = Vector2(30, 30)
	$Player/PlayerCollision.shape = player_shape
	
	# Door collisions
	var door_shape = RectangleShape2D.new()
	door_shape.size = Vector2(100, 50)
	
	$Overworld/Room1Door/Room1DoorCollision.shape = door_shape
	$Overworld/Room2Door/Room2DoorCollision.shape = door_shape
	$Overworld/Room3Door/Room3DoorCollision.shape = door_shape
	$Room1/ExitDoor1/ExitDoor1Collision.shape = door_shape
	$Room2/ExitDoor2/ExitDoor2Collision.shape = door_shape
	$Room3/ExitDoor3/ExitDoor3Collision.shape = door_shape
	
	# Clue collisions
	var clue_shape = RectangleShape2D.new()
	clue_shape.size = Vector2(40, 40)
	
	$Room1/Clue1/Clue1Collision.shape = clue_shape
	$Room1/Clue2/Clue2Collision.shape = clue_shape
	$Room2/Clue3/Clue3Collision.shape = clue_shape
	$Room2/Clue4/Clue4Collision.shape = clue_shape
	$Room3/Clue5/Clue5Collision.shape = clue_shape
	$Room3/Clue6/Clue6Collision.shape = clue_shape

func connect_door_signals():
	# Overworld doors
	$Overworld/Room1Door.body_entered.connect(_on_room1_door_entered)
	$Overworld/Room2Door.body_entered.connect(_on_room2_door_entered)
	$Overworld/Room3Door.body_entered.connect(_on_room3_door_entered)
	
	# Room exit doors
	$Room1/ExitDoor1.body_entered.connect(_on_exit_door_entered)
	$Room2/ExitDoor2.body_entered.connect(_on_exit_door_entered)
	$Room3/ExitDoor3.body_entered.connect(_on_exit_door_entered)

func connect_clue_signals():
	# Room 1 clues
	$Room1/Clue1.body_entered.connect(_on_clue_entered.bind("bloodstained_glove"))
	$Room1/Clue2.body_entered.connect(_on_clue_entered.bind("broken_mirror"))
	
	# Room 2 clues
	$Room2/Clue3.body_entered.connect(_on_clue_entered.bind("poison_bottle"))
	$Room2/Clue4.body_entered.connect(_on_clue_entered.bind("torn_letter"))
	
	# Room 3 clues
	$Room3/Clue5.body_entered.connect(_on_clue_entered.bind("secret_passage"))
	$Room3/Clue6.body_entered.connect(_on_clue_entered.bind("final_clue"))

# Player Movement (handled by CharacterBody2D)
func _physics_process(_delta):
	if game_ended:
		return
	
	var velocity = Vector2.ZERO
	
	# Get input
	if Input.is_action_pressed("Right") or Input.is_key_pressed(KEY_D):
		velocity.x += 1
	if Input.is_action_pressed("Left") or Input.is_key_pressed(KEY_A):
		velocity.x -= 1
	if Input.is_action_pressed("Down") or Input.is_key_pressed(KEY_S):
		velocity.y += 1
	#if Input.is_action_pressed("Jump") or Input.is_key_pressed(KEY_W):
		#velocity.y -= 1
	
	# Apply movement
	if velocity.length() > 0:
		velocity = velocity.normalized() * 200.0
		player.velocity = velocity
		player.move_and_slide()
		
		# Constrain player to background boundaries
		constrain_player_to_background()
		
		# Play run animation
		if player_sprite.animation != "Run":
			player_sprite.play("Run")
	else:
		# Play idle animation when not moving
		if player_sprite.animation != "Idle":
			player_sprite.play("Idle")

# Constrain player to background boundaries
func constrain_player_to_background():
	var player_pos = player.position
	var constrained_pos = player_pos
	
	match current_room:
		"overworld":
			# Constrain to background image boundaries
			constrained_pos = Vector2(
				clamp(player_pos.x, background_bounds.position.x, background_bounds.position.x + background_bounds.size.x),
				clamp(player_pos.y, background_bounds.position.y, background_bounds.position.y + background_bounds.size.y)
			)
		"room1", "room2", "room3":
			# Constrain to screen boundaries for rooms (you can adjust these values)
			constrained_pos = Vector2(
				clamp(player_pos.x, 50, 1230),  # Screen width minus margins
				clamp(player_pos.y, 50, 670)    # Screen height minus margins
			)
	
	player.position = constrained_pos

# Door Entered Signals
func _on_room1_door_entered(_body):
	if _body == player:
		enter_room("room1")

func _on_room2_door_entered(_body):
	if _body == player:
		enter_room("room2")

func _on_room3_door_entered(_body):
	if _body == player:
		enter_room("room3")

func _on_exit_door_entered(_body):
	if _body == player:
		enter_overworld()

# Clue Interaction
func _on_clue_entered(clue_name: String, _body):
	if _body == player and clue_name not in clues_found:
		pick_clue(clue_name)

func pick_clue(clue_name: String):
	# Find clue data
	var clue_info = null
	for clue in clue_data:
		if clue.name == clue_name:
			clue_info = clue
			break
	
	if clue_info:
		clues_found.append(clue_name)
		show_clue_text(clue_info.text)
		
		# Remove clue from scene
		var clue_node = get_clue_node(clue_name)
		if clue_node:
			clue_node.queue_free()
		
		# Check win condition
		if clues_found.size() >= CLUES_NEEDED:
			game_over(true)
		else:
			# Show progress
			var remaining = CLUES_NEEDED - clues_found.size()
			show_clue_text(clue_info.text + "\n\nClues remaining: " + str(remaining))

func get_clue_node(clue_name: String) -> Node:
	match clue_name:
		"bloodstained_glove":
			return $Room1/Clue1
		"broken_mirror":
			return $Room1/Clue2
		"poison_bottle":
			return $Room2/Clue3
		"torn_letter":
			return $Room2/Clue4
		"secret_passage":
			return $Room3/Clue5
		"final_clue":
			return $Room3/Clue6
		_:
			return null

# Room Management
func enter_room(room_name: String):
	current_room = room_name
	show_room(room_name)
	show_clue_text("You entered the " + room_name.replace("room", "Room ") + ". Search for clues!")

func enter_overworld():
	if current_room != "overworld":
		# Sanity drain when entering overworld
		sanity -= 10
		current_room = "overworld"
		show_room("overworld")
		
		# Check lose condition
		if sanity <= 0:
			game_over(false)
		else:
			show_clue_text("You returned to the overworld. Your sanity decreased...")
			update_ui()

func show_room(room_name: String):
	# Hide all rooms
	overworld.visible = false
	room1.visible = false
	room2.visible = false
	room3.visible = false
	
	# Show selected room
	match room_name:
		"overworld":
			overworld.visible = true
		"room1":
			room1.visible = true
		"room2":
			room2.visible = true
		"room3":
			room3.visible = true

# UI Management
func update_ui():
	sanity_label.text = "Sanity: " + str(sanity)
	
	# Update sanity overlay (darker as sanity decreases)
	var opacity = 1.0 - (sanity / 100.0)
	sanity_overlay.color.a = opacity * 0.7  # Max 70% opacity

func show_clue_text(text: String):
	clue_label.text = text
	# Clear text after 3 seconds
	await get_tree().create_timer(3.0).timeout
	if clue_label.text == text:  # Only clear if no new text was shown
		clue_label.text = ""

# Win/Lose Conditions
func game_over(won: bool):
	game_ended = true
	get_tree().paused = true
	
	if won:
		show_clue_text("🎉 You solved the murder mystery!\n\nThe butler did it! You found all the evidence needed to prove his guilt. Justice has been served!")
		instructions.text = "Congratulations! Press F5 to restart."
	else:
		show_clue_text("💀 You've lost yourself to madness...\n\nYour sanity reached zero and you became one with the haunted manor. The mystery remains unsolved...")
		instructions.text = "Game Over! Press F5 to restart."

# Input handling for restart
func _input(event):
	if game_ended and event is InputEventKey and event.pressed:
		if event.keycode == KEY_F5:
			get_tree().paused = false
			get_tree().reload_current_scene()
