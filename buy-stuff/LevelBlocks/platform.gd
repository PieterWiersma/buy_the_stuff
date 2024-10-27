extends StaticBody2D

var increment: float

func _ready() -> void:
	increment = (randf() * 1000) 
	self.scale.x = clamp(randf(), 0.2, 0.4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -=  increment * delta
	
	
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free() # Replace with function body.
