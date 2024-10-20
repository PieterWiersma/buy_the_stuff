extends Node2D

signal exit_shop
signal buy_jumps
signal buy_hover


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_buy_jumps():
	buy_jumps.emit()

func _on_button_play():
	exit_shop.emit()
	
func _on_button_buy_hover():
	buy_hover.emit()
	
func _on_button_show_shop():
	$show_shop.hide()
	get_tree().call_group("ShopElements", "show")

func check_stats(n_jumps: int, hover_time: float, coins: int):
	$NoJumpLabel.text = str(n_jumps) + ' Jump available'
	$NoHoverLabel.text = str(hover_time) + ' sec Hover available'
	$AvailableCoins.text = "coins to spend: " + str(coins)
	
