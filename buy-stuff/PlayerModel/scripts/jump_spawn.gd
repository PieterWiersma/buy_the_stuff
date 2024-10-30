extends Node

class_name JumpSpawn

var ANIMATION_TIME: float = 0.1

var increment: int
var player: Player # needs to be provided by spawner
var cumdelta: float

var original_color: Color
var original_light: Vector2
var original_shader: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.increment = 720
	
	# Color
	self.original_color = player.color_rect.color
	player.color_rect.color = Color(1.0, 1.0, 1.0)
	
	# Shader
	self.original_shader = player.color_rect.material.get_shader_parameter('fall_off_scale')
	player.color_rect.material.set_shader_parameter('fall_off_scale', 10)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Rotate the  player
	self.increment -= 10
	self.cumdelta += delta 
	player.rotation_degrees += self.increment * delta
	if self.cumdelta > self.ANIMATION_TIME:
		self.queue_free()


func _exit_tree() -> void:
	# Ensure we leave with the correct color & light & Shader
	player.color_rect.color = original_color
	player.color_rect.material.set_shader_parameter('fall_off_scale', original_shader)
