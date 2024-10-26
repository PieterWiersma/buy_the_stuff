extends Node

var game_settings = GameSettings.new()

# Constants
var MAX_DOWNFORCE: int = 1000
var MAX_LIFT: int  = -1000

# Variables for level to adjust
var downforce_increment: int = 1000

func _physics_process(delta: float) -> void:
	for entity in get_tree().get_nodes_in_group("gravity_affected"):
		if 'floored' in entity:
			if entity.floored:
				# TODO fix this // or remove ceilings metatag?
				entity.velocity.y = 0
				continue
				
		var new_velocity = entity.velocity.y + (downforce_increment * delta)
		new_velocity = clamp(new_velocity, MAX_LIFT, MAX_DOWNFORCE)
		entity.velocity.y = new_velocity
