extends Node

@export var box_scene: PackedScene
@export var coin_scene: PackedScene
@export var skull_scene: PackedScene

signal coin_collected

var increment: float = 0.001

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 400:
		var star = Star.new()
		star.size = Vector2(randf() * 3,randf() * 3,)
		star.position.y = randf() * 560
		star.position.x = randf() * 1100
		add_child(star)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $SkullTimer.wait_time > 0.5:
		$SkullTimer.wait_time -= increment


func _on_box_timer_timeout():
	# Create a new instance of the Mob scene.
	var new_box = box_scene.instantiate()

	# Choose a random location on Path2D.
	var box_spawn_location = $BoxPath/PathFollow2D
	box_spawn_location.progress_ratio = randf()
	
	# Set the mob's position to a random location.
	new_box.position = box_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(new_box)


func _on_coin_timer_timeout():
	# Create a new instance of the Mob scene.
	var coin = coin_scene.instantiate()

	# Choose a random location on Path2D.
	var coin_spawn_location = $BoxPath/PathFollow2D
	coin_spawn_location.progress_ratio = randf()
	
	# Set the mob's position to a random location.
	coin.position = coin_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(coin)
	
	
func _on_skull_timer_timeout():
	# Create a new instance of the Mob scene.
	var skull = skull_scene.instantiate()

	# Choose a random location on Path2D.
	var skull_spawn_location = $BoxPath/PathFollow2D
	skull_spawn_location.progress_ratio = randf()
	
	# Set the mob's position to a random location.
	skull.position = skull_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(skull)

func start_level() -> void:
	get_tree().call_group("lvl_object", "queue_free")
	$SkullTimer.wait_time = 3
