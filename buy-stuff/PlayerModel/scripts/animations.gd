
extends Node

var player_settings: PlayerSettings = PlayerSettings.new()

@export var hover_effect: PackedScene


var global_player: Player

var last_animation: String 

func _ready(): 
	pass

func set_animation(player: Player, animation: String):
	if last_animation == animation:
		return 

	# Delete the old animation, then create a new one
	for child in self.get_children():
		self.remove_child(child)
		
	var new_animation
	if animation == 'hover':
		player.color_rect.hide()
		
		new_animation = hover_effect.instantiate()
		new_animation.player = player
		self.add_child(new_animation)
	else:
		player.color_rect.show()
		
		new_animation = PlayerAnimationWalk.new()
		new_animation.player = player
		new_animation.rotation_speed = player_settings.ROTATION_SPEED
		self.add_child(new_animation)
			
	last_animation = animation


func do_effect(player: Player, effect: String):
	global_player = player
	# Effect manipulate shaders, the timer resets parameters
	if effect == 'jump':
		# Adapt Shader
		# TODO 
		player.get_node('ColorRect').material.set_shader_parameter('bness', 0.1)
		player.get_node('ColorRect').material.set_shader_parameter('fall_off_scale', 1)
		player.get_node('EffectTimer').wait_time = 0.1
		player.get_node('EffectTimer').start()
		
	
func _on_effect_timer_timeout() -> void:
	global_player.get_node('ColorRect').material.set_shader_parameter('bness', 0.3)
	global_player.get_node('ColorRect').material.set_shader_parameter('fall_off_scale', 3) # Replace with function body.
	global_player.get_node('ColorRect').material.set_shader_parameter('rect_size', Vector2(.12, .12)) 
