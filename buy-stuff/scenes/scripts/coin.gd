extends Area2D

class_name Coin

var increment: float
var explode: bool = false

func _ready() -> void:
	increment = (randf() * 2) + 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -=  increment 
	$CollisionShape2D.position.x -= increment
	$ColorRect.position.x -= increment
	
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

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	go_explode() # Replace with function body.
	if body.name == "Player":
		body.coins += 1
