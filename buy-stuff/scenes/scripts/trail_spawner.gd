extends Marker2D

var cumdelta: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cumdelta +=  delta
	if cumdelta > 0.01:
		var trail_rect = TrailRect.new()
		get_parent().add_child(trail_rect)
		cumdelta = 0


func _on_trail_timer_timeout() -> void:
	self.set_process(false) # Replace with function body.
