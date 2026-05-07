extends RigidBody2D
class_name Stubby

var dragging := false
var hovered := false

@export var follow_speed := 35.0
@export var release_velocity_multiplier := 1.0

var tracked_velocity := Vector2.ZERO
var last_position := Vector2.ZERO

func _ready():
	last_position = global_position

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			# START DRAG
			if event.pressed and hovered:
				dragging = true
				freeze = true

			# RELEASE DRAG
			elif !event.pressed and dragging:
				dragging = false
				freeze = false
				linear_velocity = tracked_velocity * release_velocity_multiplier

func _physics_process(delta):
	if dragging:
		var mouse_pos = get_global_mouse_position()
		# Smooth direct movement
		global_position = global_position.lerp(
			mouse_pos,
			1.0 - exp(-follow_speed * delta)
		)

		# Track velocity for throwing
		tracked_velocity = (global_position - last_position) / delta
	last_position = global_position


func _on_area_mouse_entered() -> void:
	hovered = true


func _on_area_mouse_exited() -> void:
	hovered = false
