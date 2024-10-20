extends ColorRect

var screen_size # Size of the game window.

var rotate_speed: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
func rotate():
	self.rotation = fmod(rotate_speed + self.rotation, 360)
