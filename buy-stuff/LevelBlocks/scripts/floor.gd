extends Area2D

@export var velocity_change: int = 0
@export var is_floor: bool = true

var inc = 0 
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if is_floor:
			body.n_jumps = 0
