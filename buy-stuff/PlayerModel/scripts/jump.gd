extends Node

@export var loader: PackedScene

var gs = GameSettings.new()
var ps = PlayerSettings.new()

var jump_speed: int 
var player: Player

# internals
var just_hovered: bool = false

func _ready() -> void:
	player = get_parent()
	jump_speed = ps.JUMP_SPEED


func jump_in():
	if $InputDelay.is_stopped():
		$InputDelay.start()


func jump_out():
	player.floored = false
	if not $InputDelay.is_stopped():
		$InputDelay.stop()
		self._jump()


func _jump():
	if player.max_jumps > player.n_jumps:
		# add to jumps, remove floored status, jump
		player.n_jumps += 1
		player.velocity.y = -jump_speed 
		
		player.animations.do_effect('jump')
		
		# Create animation
		var jump_spawn = JumpSpawn.new()
		jump_spawn.player = player
		self.add_child(jump_spawn)
		

func _hover_start():
	if $HoverTimerReset.is_stopped():
		just_hovered = true
		
		$HoverTimer.wait_time = player.max_hover
		$HoverTimer.start()
		player.animations.set_animation('hover')
		player.remove_from_group(gs.GRAVITY_GROUP) 
		player.velocity.y = 0

		# technically an effect maybe?
		var new_loader = loader.instantiate()
		new_loader.visible = player.visible
		new_loader.rotation_speed_sec = player.max_hover 
		new_loader.position = player.position + Vector2(-50,-50)
		new_loader.size = Vector2(2,2)
		add_child(new_loader)
	

func _on_jump_timer_timeout() -> void:
	self._hover_start()


func _on_hover_timer_timeout() -> void:
	player.animations.set_animation('walk')
	unhover() # Player should exist at this point
	

func unhover():
	if just_hovered:
		if get_node('Loader'):
			get_node('Loader').queue_free()
		$HoverTimerReset.start()
		just_hovered = false
		
	player.add_to_group(gs.GRAVITY_GROUP)
	player.jump_allowed = true
	player.animations.set_animation('walk')


func clear_all():
	pass
