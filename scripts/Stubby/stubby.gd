extends Node
class_name Stubby

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_mouse_entered() -> void:
	emit_signal("mouse_on", self)
	pass # Replace with function body.


func _on_area_mouse_exited() -> void:
	emit_signal("mouse_off", self)
	pass # Replace with function body.
