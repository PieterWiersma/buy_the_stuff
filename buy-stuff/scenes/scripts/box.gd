extends RigidBody2D

class_name Box

var increment: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	increment = randf() * 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -=  increment 
	$CollisionShape2D.position.x -= increment
	$ColorRect.position.x -= increment

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func go_explode() -> void:
	# TODO add timer and animation
	queue_free() 
	
