extends ColorRect

class_name Star

var increment: float = randf()
var speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = randf() * 0.005

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# pulsating
	increment = fmod(increment, 1) + speed
	self.color.a = increment
