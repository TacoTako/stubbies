extends Node
class_name WindowManager

@onready var screen_size := DisplayServer.screen_get_usable_rect().size

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	set_process(false)

func update_screen_size() -> void:
	screen_size = DisplayServer.screen_get_usable_rect().size
