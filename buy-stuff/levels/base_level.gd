extends Node

class_name BaseLevel

signal sgnl_player_died(score)

# level stats
var highscore: int 
var score: int

# internals
var cumdelta:float
var started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_score(delta):
	if self.started:
		$Background/Score.text  =  str(self.score)
		self.score += delta*100
	else:
		$Background/Score.text = ""
		self.score = 0

func _on_player_sgnl_player_died() -> void:
	pass

func _on_dead_timer_timeout() -> void:
	$Background/DeadLabel.hide()
	sgnl_player_died.emit(score) 
