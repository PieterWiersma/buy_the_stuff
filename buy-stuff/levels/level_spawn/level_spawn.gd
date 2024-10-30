extends Node

@export var box_scene: PackedScene
@export var coin_scene: PackedScene
@export var skull_scene: PackedScene
@export var platform_scene: PackedScene

signal sgnl_player_died(score)

var increment: float = 0.001

# level stats
var highscore: int 
var score: int

# internals
var cumdelta:float
var started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make a background
	for i in 400:
		var star = Star.new()
		star.size = Vector2(randf() * 3,randf() * 3,)
		star.position.y = randf() * 560
		star.position.x = randf() * 1100
		add_child(star)

	$Player.sgnl_player_died.connect(_on_player_sgnl_player_died)
	if not get_parent().name == 'root':
		$Player.position  = Vector2(120,50)
		$Player.fugue_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.cumdelta += delta
	self.set_score(delta)
	
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


func _on_platform_timer_timeout() -> void:
		# Create a new instance of the Mob scene.
	var platform = platform_scene.instantiate()

	# Choose a random location on Path2D.
	var platform_spawn_location = $BoxPath/PathFollow2D
	platform_spawn_location.progress_ratio = randf()
	
	# Set the mob's position to a random location.
	platform.position = platform_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(platform)


func set_score(delta):
	if self.started:
		$Background/Score.text  =  str(self.score)
		self.score += delta*100
	else:
		$Background/Score.text = ""
		self.score = 0


func start_level() -> void:
	self.started = true
	get_tree().call_group("lvl_object", "queue_free")
	$SkullTimer.wait_time = 3
	$Player.unfugue_state()
	$Player.start(250,10)
	$Background/Score.show()
	$Player.n_jumps = 0
	spawn_start_blocks()


func _on_player_sgnl_player_died() -> void:
	self.started = false
	$Background/DeadTimer.start()
	$Background/DeadLabel.show()
	$Background/DeadLabel.text = str(self.score)
	$Background/Score.hide()


func _on_dead_timer_timeout() -> void:
	$Background/DeadLabel.hide()
	sgnl_player_died.emit(score) 


func spawn_start_blocks():
	for i in 2:
		var new_box = box_scene.instantiate()
		new_box.position.y = 400
		new_box.position.x = 500 + 300 * i
		add_child(new_box)
