extends ColorRect

var increment: int = 3600

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position = player.position - player.size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = player.position - player.size / 2
	increment -= 10
	self.rotation_degrees = fmod(rotation_degrees + increment * delta, 360) 
