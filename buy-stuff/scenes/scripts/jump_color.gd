extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.size.y > 20:
		self.size.y -= 1
	if self.size.x > 20:
		self.size.x -= 1
