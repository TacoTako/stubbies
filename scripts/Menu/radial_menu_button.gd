extends Node2D
class_name RadialButton

signal clicked

@onready var button := $Button
@export var button_name := "Placeholder"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_pressed() -> void:
	print("click")
	emit_signal("clicked")
