extends Node2D


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#$VisibleOnScreenNotifier2D.screen_exited.connect(
		#get_parent()._on_visible_on_screen_notifier_2d_screen_exited
		#)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#$VisibleOnScreenNotifier2D.position.y -= 250 * delta
	##print($VisibleOnScreenNotifier2D.global_position)
