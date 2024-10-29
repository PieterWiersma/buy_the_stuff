extends Node

var gs = GameSettings.new()


func _physics_process(delta: float) -> void:
	for entity in get_tree().get_nodes_in_group("gravity_affected"):
		if 'floored' in entity:
			if entity.floored:
				entity.velocity.y = 0
				continue
				
		var new_velocity = entity.velocity.y + (gs.DOWNFORCE * delta)
		new_velocity = clamp(new_velocity, gs.MAX_LIFT, gs.MAX_DOWNFORCE)
		entity.velocity.y = new_velocity
