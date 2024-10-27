extends Area2D

class_name Skull

@export var x_speed: int 

var increment: float
var explode: bool = false

func _ready() -> void:
	if not x_speed:
		x_speed = randf() * 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -=  x_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die()
