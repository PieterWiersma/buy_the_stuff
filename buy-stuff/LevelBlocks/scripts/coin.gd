extends Area2D

class_name Coin

@export var x_speed: int

var increment: float
var explode: bool = false

func _ready() -> void:
	
	if x_speed == 0:
		x_speed = (randf() * 400) + 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -=  x_speed * delta
	
	# Better to use notifier,but that seemed buggy..
	if global_position.x + (($ColorRect.size.x/2) * $ColorRect.scale.x) < 0:
		queue_free()
	
	if explode:
		$ColorRect.rotation += 2
		$ColorRect.size.y += 1
		$ColorRect.size.x += 1	
		if not $ExplosionTimer.time_left:
			hide()


func go_explode() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$ExplosionTimer.start()
	explode = true


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		go_explode()
		body.coins += 1
