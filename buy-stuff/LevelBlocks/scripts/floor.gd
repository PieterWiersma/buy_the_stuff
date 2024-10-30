extends Area2D

@export var velocity_change: int = 0
@export var is_floor: bool = true

var inc = 0 
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if is_floor:
			body.n_jumps = 0
			
		if not self.is_floor:
			body.velocity.y = 10
 


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		
		# this helps with falling of platforms
		if body.velocity.y > 0:
			body.velocity.y -= body.velocity.y
