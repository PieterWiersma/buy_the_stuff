extends RigidBody2D

class_name Skull

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
