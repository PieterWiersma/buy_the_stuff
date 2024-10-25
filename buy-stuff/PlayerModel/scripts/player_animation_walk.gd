extends Node

class_name PlayerAnimationWalk

var player: Player
var rotation_speed: int


func _process(delta: float) -> void:
	var rotation_speed_adjustment = rotation_speed

	if player.floored:
		rotation_speed_adjustment = rotation_speed / 2
	
	if player.rotation_degrees + (rotation_speed_adjustment * delta) < 360:
		player.rotation_degrees += (rotation_speed_adjustment * delta)
	else:
		player.rotation_degrees = 360 - (rotation_speed_adjustment * delta) 
