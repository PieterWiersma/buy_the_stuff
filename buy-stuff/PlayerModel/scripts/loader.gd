extends Node2D

class_name Loader

var bg_color: String
var pointer_color: String

var rotation_speed_sec: float = 3 # 360 equals 1 rotation in 1 second
var stutter: float = 0.01 # max number of frames a sec
var color: String = "#572084"
var size: Vector2 = Vector2(10,10)

var filler
var radius: int = 5 # size

# internals
var rotation_speed

var cumdelta: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KillTimer.wait_time = rotation_speed_sec
	$KillTimer.start()
	
	$Filler.scale = size
	$Filler.default_color = color
	if self.rotation_speed_sec == 0:
		self.rotation_speed_sec = 0.01
		
	self.rotation_speed = 360 / self.rotation_speed_sec


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.cumdelta += delta
	$Pointer.rotation_degrees = fmod($Pointer.rotation_degrees + self.rotation_speed * delta, 360)	
	
	if cumdelta > self.stutter:
		var point_position_x = \
			radius * cos(deg_to_rad($Pointer.rotation_degrees - 90)) 
			
		var point_position_y = \
			radius * sin(deg_to_rad($Pointer.rotation_degrees - 90)) 

		$Filler.add_point(Vector2(point_position_x, point_position_y))
		self.cumdelta = 0
		
		pass
		
func _kill():
	self.queue_free()
