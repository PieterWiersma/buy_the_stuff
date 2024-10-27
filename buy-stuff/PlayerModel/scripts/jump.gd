extends Node

@export var loader: PackedScene

var game_settings = GameSettings.new()

var jump_speed: int
var player: Player

# internals
var just_hovered: bool = false

func jump(player_arg: Player, jump_speed_arg: int):
	# TODO
	player = player_arg
	jump_speed = jump_speed_arg
	player.floored = false
	if $InputDelay.is_stopped():
		print('start')
		$InputDelay.start()
	else:
		print('stop')
		$InputDelay.stop()
		_hover_start()


func _hover_start():
	if $HoverTimerReset.is_stopped():
		just_hovered = true
		
		$HoverTimer.wait_time = player.max_hover
		$HoverTimer.start()
		player.animations.set_animation(player, 'hover')
		player.remove_from_group(game_settings.GRAVITY_GROUP) 
		player.velocity.y = 0

		# technically an effect maybe?
		var new_loader = loader.instantiate()
		
		new_loader.rotation_speed_sec = player.max_hover 
		new_loader.position = player.position + Vector2(-50,-50)
		new_loader.size = Vector2(2,2)
		add_child(new_loader)
	

func _on_jump_timer_timeout() -> void:
	if player.max_jumps > player.n_jumps:
		# add to jumps, remove floored status, jump
		player.n_jumps += 1
		player.velocity.y = -jump_speed 
		
		# Create animation
		var jump_spawn = JumpSpawn.new()
		jump_spawn.player = player
		self.add_child(jump_spawn)
		

func _on_hover_timer_timeout() -> void:
	player.animations.set_animation(player, 'walk')
	unhover(player) # Player should exist at this point
	

func unhover(player_ref: Player):
	if just_hovered:
		if get_node('Loader'):
			get_node('Loader').queue_free()
		$HoverTimerReset.start()
		just_hovered = false
		
	player_ref.add_to_group(game_settings.GRAVITY_GROUP)
	player_ref.jump_allowed = true
	player_ref.animations.set_animation(player_ref, 'walk')


func clear_all():
	pass
