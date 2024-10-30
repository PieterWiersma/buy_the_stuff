extends Node

signal play
signal shop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StartTimer.start()
	$PlayButton.hide()
	$ShopButton.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_play_button_button_down() -> void:
	play.emit()

func _on_shop_button_button_down() -> void:
	shop.emit()

func _on_start_timer_timeout() -> void:
	$PlayButton.show()
	$ShopButton.show()
	$StartScreen.queue_free()

func _on_change_2_level_0() -> void:
	var new_scene = preload("res://levels/level_0/level_0.tscn").instantiate()
	change_level(new_scene)
	
func _on_change_2_level_spawn() -> void:
	var new_scene = preload("res://levels/level_spawn/level_spawn.tscn").instantiate()
	change_level(new_scene)

func change_level(new_scene: Node):
	# TODO ugly use of root
	var root = get_parent()
	root.remove_child(root.get_node('Level'))
	root.add_child(new_scene)
	root.move_child(new_scene, 0)
	new_scene.name = 'Level'
	new_scene.sgnl_player_died.connect(root._on_level_sgnl_player_died)
	root.player = new_scene.get_node('Player')
	print('fsdfsd')
