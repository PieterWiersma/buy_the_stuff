extends Node

# will be initial stats
var player: Player 
var player_stats = {
	"max_jumps": 4,
	"max_hover": 1,
	"coins": 100
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Shop.hide()
	$Level.show()
	if $Level.has_node("Player"):
		player = $Level.get_node("Player")
	

func _on_menu_play() -> void:
	play() # Replace with function body.


func _on_menu_shop() -> void:
	$Shop.check_stats(
		player_stats.max_jumps, 
		player_stats.max_hover, 
		player_stats.coins
	)
	$Menu.hide()
	$Shop.show()


func _on_exit_shop():
	$Shop.hide()
	$Menu.show()
	apply_player_stats()

func _on_level_sgnl_player_died() -> void:
	print('sf')
	get_player_stats()
	$Menu.show()

func _on_shop_buy_hover() -> void:
	if player_stats.coins > 0:
		player_stats.max_hover += 0.33 
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
		player_stats.max_hover, 
		player_stats.coins
	)

func play():
	$Menu.hide()
	$Level.start_level()
	apply_player_stats()


func get_player_stats():
	if self.player:
		player_stats.max_jumps = self.player.max_jumps
		player_stats.max_hover = self.player.max_hover
		player_stats.coins = self.player.coins


func apply_player_stats():
	if self.player:
		self.player.max_jumps = player_stats.max_jumps
		self.player.max_hover = player_stats.max_hover
		self.player.coins = player_stats.coins 


func load_player_stats_from_file():
	# TODO modulise
	pass
	
func save_player_stats_to_file():
	# TODO modulise
	pass
