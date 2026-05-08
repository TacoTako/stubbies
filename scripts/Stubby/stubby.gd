extends RigidBody2D
class_name Stubby

@onready var sprite := get_node("Sprite2D")

@export var squash_strength := 1.2
@export var follow_speed := 35.0
@export var release_velocity_multiplier := 1.0

var dragging := false
var hovered := false

var target_scale := Vector2.ONE
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

	# Squash/Stretch code
	sprite.scale = scale.lerp(target_scale, delta * 15.0)
	# Slowly return to normal size
	target_scale = target_scale.lerp(Vector2.ONE, delta * 10.0)
	
	last_position = global_position

func _integrate_forces(state):
	for i in state.get_contact_count():
		var normal = state.get_contact_local_normal(i)

		# Normalize collision force
		var x_force = clamp(abs(linear_velocity.x) / 600.0, 0.0, 1.0)
		var y_force = clamp(abs(linear_velocity.y) / 600.0, 0.0, 1.0)
		# Floor / ceiling hit
		if abs(normal.y) > 0.7:
			squash(y_force, false)

		# Wall hit
		elif abs(normal.x) > 0.7:
			squash(x_force, true)

		# Only trigger once per frame
		break

func squash(force : float, vertical : bool) -> void:

	var squash_amount = force * squash_strength

	if !vertical:
		target_scale = Vector2(
			1.0 + squash_amount,
			1.0 - squash_amount
		)
	else:
		target_scale = Vector2(
			1.0 - squash_amount,
			1.0 + squash_amount
		)

func _on_area_mouse_entered() -> void:
	hovered = true


func _on_area_mouse_exited() -> void:
	hovered = false
