extends RigidBody2D
class_name DraggableObject

@export var follow_speed := 35.0
@export var release_velocity_multiplier := 1.0

@onready var collision := $CollisionShape2D
var x_margin := 0.0
var y_margin := 0.0

var dragging := false
var hovered := false

var tracked_velocity := Vector2.ZERO
var last_position := Vector2.ZERO

func _ready() -> void:
	if collision.shape is CircleShape2D:
		x_margin = collision.shape.radius
		y_margin = collision.shape.radius
		print("cir")
	if collision.shape is RectangleShape2D:
		x_margin = collision.shape.size.x * 0.5
		y_margin = collision.shape.size.y * 0.5
		print("rec")
	print(x_margin, y_margin)
	
	last_position = global_position

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.pressed and hovered:
				start_drag()

			elif !event.pressed and dragging:
				finish_drag()

func _physics_process(delta):
	if dragging:
		var mouse_pos = get_restricted_mouse_pos()
		# Smooth direct movement
		global_position = global_position.lerp(
			mouse_pos,
			1.0 - exp(-follow_speed * delta)
		)

		# Track velocity for throwing
		tracked_velocity = (global_position - last_position) / delta
	
	last_position = global_position

func get_restricted_mouse_pos() -> Vector2:
	var mouse_pos = get_global_mouse_position()
	mouse_pos.x = clamp(
		mouse_pos.x,
		0 + x_margin,
		ScreenSize.screen_size.x - x_margin
		)
		
	mouse_pos.y = clamp(
		mouse_pos.y,
		0 + y_margin,
		ScreenSize.screen_size.y - y_margin
		)
	return mouse_pos

func start_drag() -> void:
	dragging = true
	freeze = true

func finish_drag() -> void:
	dragging = false
	freeze = false
	linear_velocity = tracked_velocity * release_velocity_multiplier

func _on_area_mouse_entered() -> void:
	hovered = true


func _on_area_mouse_exited() -> void:
	hovered = false
