extends StaticBody2D

@export var x_speed: int

var increment: float

# internal
var allowed_to_delete: bool = false

func _ready() -> void:
	if not x_speed:
		# mostly for test levels
		x_speed = (randf() * 1000) 
		self.scale.x = clamp(randf(), 0.2, 0.4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -=  x_speed * delta

	# Better to use notifier,but that seemed buggy..
	if global_position.x + (($ColorRect.size.x/2) * $ColorRect.scale.x) < 0:
		queue_free()
