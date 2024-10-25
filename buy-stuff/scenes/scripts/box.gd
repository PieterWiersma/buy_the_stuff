extends Area2D

class_name Box

var increment: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	increment = randf() * 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.position.x -= increment
	
func _physics_process(delta: float) -> void:
	pass

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
