extends ColorRect

class_name HoverTimerLoader

var wait_time: float = 1
var loader_size = 40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.size.x = 0
	self.size.y = 39
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	stretch_loader(delta)
	if size.x >= loader_size:
		self.queue_free()

func stretch_loader(delta):
	size.x += (loader_size / wait_time) * delta
