extends DraggableObject
class_name Pet

@onready var sprite := get_node("Sprite2D")

@export var squash_strength := 1.2

var target_scale := Vector2.ONE

func _ready():
	pass

func _process(delta):
	# Squash/Stretch code
	sprite.scale = scale.lerp(target_scale, delta * 15.0)
	# Slowly return to normal size
	target_scale = target_scale.lerp(Vector2.ONE, delta * 10.0)

func _integrate_forces(state):
	for i in state.get_contact_count():
		var normal = state.get_contact_local_normal(i)

		# Normalize collision force
		var x_force = clamp(abs(linear_velocity.x) / 600.0, 0.0, 2.0)
		var y_force = clamp(abs(linear_velocity.y) / 600.0, 0.0, 2.0)
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
