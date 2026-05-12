extends Node2D
class_name Main

@onready var floor := $Boundaries/Floor
@onready var right_wall := $Boundaries/RightWall

func _ready():
	update_stage_size()

func update_stage_size():
	var size := ScreenSize.screen_size
	DisplayServer.window_set_size(size)
	self.floor.position.y = size.y
	self.right_wall.position.x = size.x
