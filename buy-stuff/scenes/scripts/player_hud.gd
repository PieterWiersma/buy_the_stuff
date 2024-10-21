extends CanvasGroup

signal hit

var combo: int = 0

var hover_bar_width: int = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Dead.hide()
	$HUD.set_coins($Player.coins)
	$ComboLabel.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_coin() -> void:
	$HUD.set_coins($Player.coins)
	combo_meter()
	

func _on_player_hit() -> void:
	combo = 0
	hit.emit()
	

func change_combo_label(combo_text: String, text_size:int):
	$ComboLabel.text = combo_text
	$ComboLabel.show()
	$ComboDisplayTimer.start()


func show_combo(no: int):
	if combo == 3:
		change_combo_label("COMBO 3", 130)
	elif combo == 5:
		change_combo_label("COMBO 5", 250)
	elif combo == 10:
		change_combo_label("COMBO 10", 350)
	elif combo == 25:
		change_combo_label("COMBO 25", 400)
	elif combo == 50:
		change_combo_label("COMBO 50", 1500)


func hide_ui():
	get_tree().call_group("ui_element", "hide")

func show_ui():
	get_tree().call_group("ui_element", "show")


func combo_meter():
	if $ComboTimer.time_left:
		combo += 1
		show_combo(combo)
	else:
		combo = 1
	$ComboTimer.start()
	
func _on_combo_display_timer_timeout() -> void:
	$ComboLabel.hide()

func show_hover_progress():
	var max_time = $Player.hover_value
	var time_left = $Player/HoverTimer.time_left
	
	$HoverProgress.size.x = hover_bar_width * (time_left / max_time)
	
	
func _on_player_hover() -> void:
	show_hover_progress() 
	get_tree().call_group('hover_charger', 'queue_free')


func _on_player_hover_recharge() -> void:
	show_hover_progress() 


func _on_player_show_hover_stall_timer() -> void:
	var new_hover_loader = HoverTimerLoader.new()
	new_hover_loader.wait_time = $Player.hover_stall_value
	new_hover_loader.loader_size = hover_bar_width
	$HoverProgress.add_child(new_hover_loader)
	

func set_player(x,y, original_y=0):
	# original_y sets the absolute floor for the player in the map
	$Player.original_y = original_y
	$Player.position = Vector2(x,y)
