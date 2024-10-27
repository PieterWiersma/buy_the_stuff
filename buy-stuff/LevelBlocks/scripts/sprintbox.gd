extends Area2D

class_name SprintBox

@export var x_speed: int

var increment: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if not x_speed:
		x_speed = randf() * 200

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
		body.is_sprinting = true
		body.velocity.x = 500
		body.unhover()
		self.queue_free()
