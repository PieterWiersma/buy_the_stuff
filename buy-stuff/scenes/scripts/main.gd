extends Node

var player_stats = {
	"n_jumps": null,
	"hover_value": null
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Shop.hide()
	$Level1.show()
	$PlayerHud/Player.die()
	$PlayerHud.hide_ui()

func _on_menu_play() -> void:
	play() # Replace with function body.

func _on_player_hit() -> void:
	player_die()
	
func play():
	$Menu.hide()
	$Level1.start_level()
	$PlayerHud/Player.start()
	$PlayerHud.show_ui()

func player_die():
	$Menu.show()
	$PlayerHud/Player.die()
	$PlayerHud.hide_ui()

func _on_menu_shop() -> void:
	$Shop.check_stats($PlayerHud/Player.max_jumps, $PlayerHud/Player/HoverTimer.wait_time, $PlayerHud/Player.coins)
	$Menu.hide()
	$PlayerHud.hide()
	$Shop.show()

func _on_exit_shop():
	$Shop.hide()
	$PlayerHud.show()
	$Menu.show()
	$PlayerHud._on_player_coin() 
	

func _on_shop_buy_hover() -> void:
	if $PlayerHud/Player.coins > 0:
		$PlayerHud/Player.increase_hover(0.33) 
		$PlayerHud/Player.coins -= 1
	_rework_stats()

func _on_shop_buy_jumps() -> void:
	if $PlayerHud/Player.coins > 0:
		$PlayerHud/Player.max_jumps += 1
		$PlayerHud/Player.coins -= 1
	_rework_stats()

func _rework_stats():
	$Shop.check_stats($PlayerHud/Player.max_jumps, $PlayerHud/Player/HoverTimer.wait_time, $PlayerHud/Player.coins)
