extends ColorRect

class_name TrailRect

var cumdelta: float = 0
var speed: int = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO make global parameters file
	self.size = Vector2(40,40)
	self.rotation = get_parent().get_node('PlayerColor').rotation 
	
	## Then move position on Top level
	self.top_level = true
	self.global_position.x = get_parent().global_position.x - 20
	self.global_position.y = get_parent().global_position.y - 22
	self.color = get_parent().get_node('PlayerColor').color
	self.color.a = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cumdelta += delta 
	
	# trail effect
	var a = self.color.a - 0.01 * delta
	self.position.x -= speed * delta
	self.color.a = a

	# Dissapear
	if cumdelta > 0.1:
		self.queue_free()
