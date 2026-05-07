extends Node2D

@onready var transparent_window: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transparent_window = get_tree().get_first_node_in_group("transparent_window")
	if transparent_window != null:
		transparent_window.SetClickThrough(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
