#extends Node

class_name GameSettings

# CREATE THESE GLOBAL GROUPS
var GRAVITY_GROUP: String = "gravity_affected"
var WINDOWS_SIZE: int = 1100

# Gravity settings
var MAX_DOWNFORCE: int = 1000
var MAX_LIFT: int  = -1000
var DOWNFORCE: int = 1300  # Amount of downforce accumulated in 1 second 

# Item settings
var JUMPBOX_LIFT: int = 600
