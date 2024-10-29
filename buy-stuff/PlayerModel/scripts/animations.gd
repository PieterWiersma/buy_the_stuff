
extends Node

var player_settings: PlayerSettings = PlayerSettings.new()

@export var hover_effect: PackedScene
@export var jump_meter: PackedScene

var player: Player

var last_animation: String 

func _ready(): 
	player = get_parent()

func set_animation(animation: String):
	if last_animation == animation:
		return 

	# Delete the old animation, then create a new one
	for child in self.get_children():
		self.remove_child(child)
		
	var new_animation
	if animation == 'hover':
		player.color_rect.hide()
		new_animation = hover_effect.instantiate()
		new_animation.visible = player.visible
		new_animation.player = player
		self.add_child(new_animation)
	else:
		player.color_rect.show()
		new_animation = PlayerAnimationWalk.new()
		new_animation.player = player
		new_animation.rotation_speed = player_settings.ROTATION_SPEED
		self.add_child(new_animation)
			
	last_animation = animation


func do_effect(effect: String):
	# Effect manipulate shaders, the timer resets parameters
	if effect == 'jump':
		# Adapt Shader
		# TODO 
		player.get_node('ColorRect').material.set_shader_parameter('bness', 0.1)
		player.get_node('ColorRect').material.set_shader_parameter('fall_off_scale', 2)
		player.get_node('EffectTimer').wait_time = 0.1
		player.get_node('EffectTimer').start()
		
		spawn_jump_meter()
		

func spawn_jump_meter():
	# add jump meter
	var new_jump_meter = jump_meter.instantiate()
	new_jump_meter.player = player
	new_jump_meter.visible = player.visible
	add_child(new_jump_meter)

	
func _on_effect_timer_timeout() -> void:
	player.get_node('ColorRect').material.set_shader_parameter('bness', 0.3)
	player.get_node('ColorRect').material.set_shader_parameter('fall_off_scale', 3) # Replace with function body.
	player.get_node('ColorRect').material.set_shader_parameter('rect_size', Vector2(.12, .12)) 
