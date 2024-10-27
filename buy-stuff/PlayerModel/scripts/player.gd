# I mostly want to use this main class to handle interactions of the player

extends CharacterBody2D

class_name Player

signal sgnl_player_died()

# Variables others to set
@export var level_position: Vector2 = Vector2(250,250)

var game_settings: GameSettings = GameSettings.new()
var player_settings: PlayerSettings = PlayerSettings.new()

# Variables for others to interact with
var jump_speed: int = player_settings.JUMP_SPEED
var size: Vector2 
var color_rect: ColorRect
var animations: Object

# Variables for others to read
var floored: bool = false
var jump_allowed: bool = true

# Variables for player progress
var coins: int = 10
var max_jumps: int = 20
var max_hover: float = 1.0

# variables for internal process
var n_jumps: int = 0
var is_dead: bool = false
var is_sprinting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.size = $ColorRect.size
	self.color_rect = $ColorRect
	self.animations = $Animations
	self.add_to_group(game_settings.GRAVITY_GROUP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle inputs

	# jump actions
	if Input.is_action_just_pressed('jump'):
		$Jump.jump(self, jump_speed)
		$Animations.do_effect(self, 'jump')
		
	if Input.is_action_just_released("jump"):
		$Jump.unhover(self)
		$Animations.set_animation(self, 'walk')
		

func _physics_process(delta: float) -> void:
	# This handles the player movement, though actual inputs are
	# handled in respective 'modules'

	# Keep player on 50% of the screen // boost between 20 and 50
	if is_sprinting and self.position.x > game_settings.WINDOWS_SIZE * 0.50:
		self.velocity.x = -200
		is_sprinting = false
	if not is_sprinting and self.position.x < game_settings.WINDOWS_SIZE * 0.20:
		self.velocity.x = 0

	# Handle interactions
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider().get('velocity_change'):
			self.velocity.y += collision_info.get_collider().get('velocity_change')

		# Standard behaviour when ap proaching a floor
		if collision_info.get_collider().get_meta('is_floor', true):
			# If we land, we're allowed to jump again
			self.n_jumps = 0
			
			# this will always compensate for the increase in velocity
			# without removing the option to jump
			if self.velocity.y > 0:
				self.velocity.y += -abs(self.velocity.y)


func unhover():
	$Jump.unhover(self)

func die():
	if not is_dead:
		sgnl_player_died.emit()
		self.hide()
		is_dead = true


func start(x:int, y:int):
	self.level_position = Vector2(x, y)
	if is_dead:
		self.show()
		self.position = self.level_position
		is_dead = false
