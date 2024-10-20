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
