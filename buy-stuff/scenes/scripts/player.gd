extends Area2D

signal hit
signal coin

signal hover
signal hover_stop
signal hover_recharge
signal show_hover_stall_timer

var screen_size # Size of the game window.

# Easthetics
var SIZE_Y = 40
var SIZE_X = 40
var SIZE_JUMP_Y_INCREMENT = 1
var SIZE_JUMP_Y = 20
var ORIGINAL_COLOR = "#ab0000"
var original_y: float 

# Coins, health, that stuff
var coins: int = 0

# Hover variables
var hover_value: float = 0.5
var hover_stall_value: float = 0.5
var hover_allowed: bool = true

# jumping variables
var is_jumping: bool = false
var jump_height: int = 50
var gravity_modifier: float = 1.3
var jump_speed: float = 0
var max_jumps: int = 2
var fuck_gravity: bool = false

# process
var jump_intensity: float
var n_jumps: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	
# Called every frame 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_jump(delta)
	if $PlayerColor.size.y < SIZE_Y:
			$PlayerColor.size.y += SIZE_JUMP_Y_INCREMENT
	
	
func check_jump(delta: float):
	var time = 0
	# If pressed, just chec
	if Input.is_action_just_pressed('jump'):
		$KeyPress.start()
	elif not $KeyPress.time_left and Input.is_action_pressed('jump'): 
		go_hover()
	elif Input.is_action_just_released('jump'):
		hover_stop.emit()
		if $KeyPress.time_left:
			# the harder you press
			jump(jump_height)
	
	gravity(delta)
	
	
func jump(intensity: int):
	$PlayerColor.size.y = SIZE_JUMP_Y
	$PlayerColor/JumpColor.size += Vector2(10, 10)
	if not n_jumps >= max_jumps:
		# add a little speed
		jump_intensity = intensity
		n_jumps += 1

func disallow_hover():
	$HoverTimer/HoverAllowed.start()
	hover_allowed = false

func go_hover():
	if not hover_allowed:
		return
		
	hover.emit()
	if $HoverTimer.time_left > 0:
		jump_intensity = 0
		fuck_gravity = true
		$PlayerColor.color = '#d9d497'
		$PlayerColor.rotate()
	else:
		pass


func gravity(delta: float):		
	
	if fuck_gravity:
		fuck_gravity = false
		return
	
	# TODO move
	$PlayerColor.color = ORIGINAL_COLOR
	
	# we either rise or fall
	# Calculate whether there was a jump, and if so jump
	var height_diff = jump_intensity * (delta*10) 
	
	# Assuming you didn't hit the ceiling # TODO make variable
	if position.y - height_diff <= 0:
		height_diff = position.y 
		jump_intensity = jump_intensity * -1
	position.y -= height_diff

	# This wil turn negative, making us come back down
	jump_intensity -= gravity_modifier
	
	# if we've reached the ground, nothing to do. also reset jump timer
	if position.y >= original_y:
		position.y = original_y
		
		# rest jumps
		$PlayerColor.rotation = 0
		n_jumps = 0
		
	# Aerial acrobatics
	else: 
		$PlayerColor.rotate()

func start():
	show()
	$PlayerCollision.set_deferred("disabled", false)

func die():
	hide()
	$PlayerCollision.set_deferred("disabled", true)

func _on_body_entered( body: Node2D) -> void:
	if body.is_in_group('box'):
		body.go_explode()
		disallow_hover()
		self.position.y += 5
		jump_intensity = body.increment * 10 
	elif body.is_in_group('coins'):
		body.go_explode()
		coins += 1
		coin.emit()
	elif body.is_in_group('death'):
		hit.emit()


func increase_hover(sec: float):
	hover_value += sec
	$HoverTimer.wait_time = hover_value


func _on_hover_timer_show_hover_stall_timer() -> void:
	show_hover_stall_timer.emit() 


func _on_hover_allowed_timeout() -> void:
	hover_allowed = true
