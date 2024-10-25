extends Node2D

var x = TestRect.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	$Timer.start()
	add_child(x)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print('main')

func _on_timer_timeout() -> void:
	x.queue_free()
