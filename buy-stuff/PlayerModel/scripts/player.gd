# I mostly want to use this main class to handle interactions of the player

extends CharacterBody2D

class_name Player

@export var player_color: Color

signal sgnl_player_died()

# Variables others to set
@export var level_position: Vector2 = Vector2(250,250)

var gs: GameSettings = GameSettings.new()
var ps: PlayerSettings = PlayerSettings.new()

# Variables for others to interact with
var size: Vector2 
var color_rect: ColorRect
var animations: Object
var jump: Object
var light: PointLight2D

# Variables for others to read
var floored: bool = false
var jump_allowed: bool = true

# Variables for player progress
var coins: int = 10
var max_jumps: int = 20
var max_hover: float = 1.0
var jump_increase: int = 0

# variables for internal process
var n_jumps: int = 0
var is_dead: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.size = $ColorRect.size
	self.color_rect = $ColorRect
	self.animations = $Animations
	self.jump = $Jump
	self.light = $PointLight2D
	
	if self.player_color:
		self.color_rect.color = self.player_color
	$Animations.set_animation('walk')
	
	self.fugue_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle inputs
	#self.position.x = level_position[0]

	# jump actions
	if Input.is_action_just_pressed('jump'):
		$Jump.jump_in()
		
	if Input.is_action_just_released("jump"):
		$Jump.jump_out()
		$Jump.unhover()
		$Animations.set_animation('walk')
	print(self.get_groups())

func _physics_process(delta: float) -> void:
	# This handles the player movement, though actual inputs are
	# handled in respective 'modules'

	# Handle interactions
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider().get("velocity_change"):
			self.velocity.y += collision_info.get_collider().get("velocity_change")

		# Standard behaviour when ap proaching a floor
		if collision_info.get_collider().get("is_floor"):
			# If we land, we're allowed to jump again
			self.n_jumps = 0
			
			# this will always compensate for the increase in velocity
			# without removing the option to jump
			if self.velocity.y > 0:
				self.velocity.y += -abs(self.velocity.y) / 10


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.die()

	
func unhover():
	$Jump.unhover()


func fugue_state():
	print("fugue")
	$SwipeScreen.set_process(false)
	$NormalCollision.disabled = true
	self.remove_from_group('gravity_affected')
	self.hide()


func unfugue_state():
	print("unfugue")
	$SwipeScreen.set_process(true)
	$NormalCollision.disabled = false
	self.add_to_group('gravity_affected')
	self.show()

func die():
	if not is_dead:
		fugue_state()
		sgnl_player_died.emit()
		is_dead = true
		print('Player Died')

func start(x:int, y:int):
	self.level_position = Vector2(x, y)
	if is_dead:
		unfugue_state()
		self.show()
		self.position = self.level_position
		is_dead = false
