extends Node2D
class_name RadialButton

signal clicked

@onready var button := $Button
@export var button_name := "Placeholder"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func animate(target_pos : Vector2, target_scale : Vector2, ease, delay : float) -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(
		self,
		"position",
		target_pos,
		0.3
	).set_trans(Tween.TRANS_BACK).set_ease(ease).set_delay(delay)

	tween.tween_property(
		self,
		"scale",
		target_scale,
		0.2
	).set_delay(delay)

func _on_button_pressed() -> void:
	emit_signal("clicked", self)
