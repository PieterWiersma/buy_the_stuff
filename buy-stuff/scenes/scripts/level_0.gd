extends Node

@export var level_blocks: PackedScene
var lvlblock_names: Array[String] = ['0', '1', '2'] # TODO get from lvlblocks

signal sgnl_player_died()

var increment: float = 0.001

var rng = RandomNumberGenerator.new()

# internals
var levels: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signal
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


func _on_level_block_timer_timeout() -> void:
	levels = level_blocks.instantiate()
	var lvl_blocks = levels.get_children()

	var random_lvlblock = rng.randi_range(0, lvl_blocks.size()-1)
	for i in lvl_blocks.size():
		if not i == random_lvlblock:
			levels.remove_child(lvl_blocks[i])
			
	add_child(levels)

func _on_player_sgnl_player_died() -> void:
	sgnl_player_died.emit()

func start_level() -> void:
	get_tree().call_group("lvl_object", "queue_free")
	$Player.start(120,10)
