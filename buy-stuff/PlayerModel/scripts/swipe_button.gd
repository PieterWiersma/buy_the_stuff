extends TouchScreenButton

# TODO move to gamesettings
var swipe_length: int = 50

# Internals
var is_swiping: bool = false
var start_position: Vector2 
var current_position: Vector2

var player: Player 

func _ready() -> void:
	player = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Recognizes swiping, will send out signal if recognized
	
	# Check where you start
	if Input.is_action_just_pressed("swipe"):
		if not is_swiping:
			is_swiping = true
			start_position = get_global_mouse_position()
			$HoverTimer.start()
			print("start")
			
	# Check if you moved enough towards up
	if Input.is_action_pressed("swipe"):
		if is_swiping:
			current_position = get_global_mouse_position()
			if start_position.distance_to(current_position) >= swipe_length:
				player.jump._jump()
				is_swiping = false
				print("jump")
		
	# Simulate release if releaseds
	if Input.is_action_just_released("swipe"):
			$HoverTimer.stop()
			is_swiping = false
			player.jump.unhover()

	
func _on_timer_timeout() -> void:
	is_swiping = false 
	player.jump._hover_start()
