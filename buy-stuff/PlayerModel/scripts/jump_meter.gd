extends Node2D

var SPACER: int = 10
var SIZE: int = 10
var USED_COLOR: String = "#000000"
var AVAILABLE_COLOR: String = "#FFFFFF"
var MAX_ROW: int = 5

var cumdelta: float = 0

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position = player.position + Vector2(20,-20)
	for i in player.max_jumps:
		var new_jump = ColorRect.new()
		new_jump.size = Vector2(SIZE,SIZE)
		new_jump.position.x = (i % MAX_ROW) * (SPACER+SIZE)
		new_jump.position.y = floor(i/MAX_ROW) * (SPACER+SIZE)

		if player.max_jumps - i > player.max_jumps - player.n_jumps:
			new_jump.color = USED_COLOR 
		else:
			new_jump.color = AVAILABLE_COLOR

		add_child(new_jump)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = player.position + Vector2(20,-20)
	cumdelta += delta
	if cumdelta > 0.4:
		self.queue_free()
