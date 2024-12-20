extends Node2D

signal dead_timer_timeout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_player_hit() -> void:
	$DeadTimer.start()
	$Dead.show()

func _on_dead_timer_timeout() -> void:
	$Dead.hide()

func set_coins(coins: int):
	$coins.text = "coins: " + str(coins)
