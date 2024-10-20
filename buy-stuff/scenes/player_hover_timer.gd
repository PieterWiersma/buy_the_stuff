extends Timer

signal show_hover_stall_timer

var new_hover_loader

var block_timer: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wait_time = get_parent().hover_value 
	self.start()
	self.paused = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_hover() -> void:
	$HoverTimerStall.stop()
	if not block_timer:
		unpause_timer()
		block_timer = true
	

func _on_player_hover_stop() -> void:
	pause_timer()
	block_timer = false
	

func _on_hover_timer_stall_timeout() -> void:
	self.wait_time = get_parent().hover_value 
	
	# stop / start to ensure it starts back at beginning
	self.stop()
	self.start()
	get_parent().hover_recharge.emit()

func unpause_timer():
	self.paused = false

func pause_timer():
	self.paused = true
	$HoverTimerStall.wait_time = get_parent().hover_stall_value
	$HoverTimerStall.start()
	show_hover_stall_timer.emit()
	
