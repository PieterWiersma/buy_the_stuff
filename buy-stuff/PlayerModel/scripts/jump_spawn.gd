extends Node

class_name JumpSpawn

var ANIMATION_TIME: float = 0.1

var increment: int
var player: Player # needs to be provided by spawner
var cumdelta: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.increment = 720

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.increment -= 10
	self.cumdelta += delta 
	player.rotation_degrees += self.increment * delta
	if self.cumdelta > self.ANIMATION_TIME:
		self.queue_free()
