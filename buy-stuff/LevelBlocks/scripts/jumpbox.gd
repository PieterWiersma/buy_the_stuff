extends Area2D

class_name JumpBox

@export var x_speed: int

var increment: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not x_speed:
		x_speed = randf() * 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.x -= x_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func go_explode() -> void:
	# TODO add timer and animation
	queue_free() 
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		body.velocity.y = -500
		body.unhover()
		self.queue_free()
