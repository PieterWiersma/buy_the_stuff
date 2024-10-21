extends Node

# will be initial stats
var player_stats = {
	"max_jumps": 44,
	"hover_value": 1,
	"coins": 100
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Shop.hide()
	$Level.show()
	apply_player_stats()
		
	

func _on_menu_play() -> void:
	play() # Replace with function body.


func _on_menu_shop() -> void:
	$Shop.check_stats(
		player_stats.max_jumps, 
		player_stats.hover_value, 
		player_stats.coins
	)
	$Menu.hide()
	$Shop.show()


func _on_exit_shop():
	$Shop.hide()
	$Menu.show()
	apply_player_stats()

func _on_player_die():
	get_player_stats()
	$Menu.show()

func _on_shop_buy_hover() -> void:
	if player_stats.coins > 0:
		player_stats.hover_value += 0.33 
		player_stats.coins -= 1
	_rework_stats()

func _on_shop_buy_jumps() -> void:
	if player_stats.coins > 0:
		player_stats.max_jumps += 1
		player_stats.coins -= 1
	_rework_stats()

func _rework_stats():
	$Shop.check_stats(
		player_stats.max_jumps, 
		player_stats.hover_value, 
		player_stats.coins
	)

func play():
	$Menu.hide()
	$Level.start_level()
	apply_player_stats()


func get_player_stats():
	if $Level.get_node_or_null('PlayerHud'):
		var player = $Level/PlayerHud/Player
		player_stats.max_jumps = player.max_jumps
		player_stats.hover_value = player.hover_value
		player_stats.coins = player.coins


func apply_player_stats():
	if $Level.get_node_or_null('PlayerHud'):
		var player = $Level/PlayerHud/Player
		player.max_jumps = player_stats.max_jumps
		player.hover_value = player_stats.hover_value
		player.coins = player_stats.coins 
		
		# This only runs on a signal
		$Level/PlayerHud/HUD.set_coins(player_stats.coins)


func load_player_stats_from_file():
	# TODO modulise
	pass
	
func save_player_stats_to_file():
	# TODO modulise
	pass
