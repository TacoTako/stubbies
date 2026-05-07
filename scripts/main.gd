extends Node2D
class_name Main

func _ready():
	update_window_size()

func _notification(what):
	if what == NOTIFICATION_WM_SIZE_CHANGED:
		# Optional: if you want to react to manual resizing too
		update_window_size()

func update_window_size():
	var screen_size = DisplayServer.screen_get_usable_rect().size
	DisplayServer.window_set_size(screen_size)
	self.get_node("Boundaries/Floor").position.y = screen_size.y
	self.get_node("Boundaries/Right Wall").position.x = screen_size.x
