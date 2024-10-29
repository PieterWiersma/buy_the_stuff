extends BaseLevel

@export var level_blocks: PackedScene
@export var start_lvl_block: PackedScene
var lvlblock_names: Array[String] = ['0', '1', '2'] # TODO get from lvlblocks

var increment: float = 0.001

var rng = RandomNumberGenerator.new()

# internals
#var levels: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signal
	self.started = true
	$Background/Score.show()
	$Player.sgnl_player_died.connect(_on_player_sgnl_player_died)
	
	if not get_parent().name == 'root':
		$Player.die()
	
	# Make a background
	for i in 400:
		var star = Star.new()
		star.size = Vector2(randf() * 3,randf() * 3,)
		star.position.y = randf() * 560
		star.position.x = randf() * 1100
		add_child(star)

	# Place the player x,y, original_y
	$Player.position  = Vector2(120,50)

func _process(delta: float) -> void:
	set_score(delta)


func _on_level_block_timer_timeout() -> void:
	spawn_level()


func spawn_level():
	print('spawn')
	var levels = level_blocks.instantiate()
	var lvl_blocks = levels.get_children()
	levels.sgnl_new_block.connect(spawn_level)

	var random_lvlblock = rng.randi_range(0, lvl_blocks.size()-1)
	for i in lvl_blocks.size():
		if not i == random_lvlblock:
			levels.remove_child(lvl_blocks[i])
			
	levels.get_child(0).show()		
	add_child(levels)


func start_level() -> void:
	self.started = true
	get_tree().call_group("lvl_object", "queue_free")
	$Player.start(250,10)
	$Player.n_jumps = 0
	add_child(start_lvl_block.instantiate())

func _on_player_sgnl_player_died() -> void:
	self.started = false
	sgnl_player_died.emit(score)
	started = false
	$Background/DeadTimer.start()
	$Background/DeadLabel.show()
	$Background/DeadLabel.text = str(self.score)
	$Background/Score.hide()
