extends Node2D

@export var x_speed: int
@export var x_scale: float
@export var is_wall: bool = false
@export var color: String

var increment: float

# internal
var allowed_to_delete: bool = false

func _ready() -> void:
	# mostly for test levels
	if not x_speed:
		x_speed = clamp((randf() * 400) + 3, 200, 900)
	if not x_scale:
		self.scale.x = clamp(randf(), 0.2, 0.4)
	if color:
		self.get_node('ColorRect').color = color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -=  x_speed * delta

	# Better to use notifier,but that seemed buggy..
	if global_position.x + (($ColorRect.size.x) * $ColorRect.scale.x) < 0:
		queue_free()
