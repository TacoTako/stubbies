extends Node2D
class_name ClickManager

# for highlighting and animations
var thing_dragged : RigidBody2D
var thing_hovered : Node2D
var tweening : Tween
var hover_enabled : bool = true

@export var spring_strength := 80.0
@export var damping := 14.0
@export var max_force := 3000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !thing_dragged:
		return

	if Input.is_action_just_released("leftMouseClick"):
		finish_drag(true)
	else:
		# dragged_card sticking to mouse
		var offset = get_global_mouse_position() - thing_dragged.position
		var force = offset * spring_strength - (thing_dragged.linear_velocity) * damping
		if force.length() > max_force:
			force = force.normalized() * max_force
		thing_dragged.apply_central_force(force)
		#card_dragged.position = Vector2(clamp(new_x, 0, screen_size.x), clamp(new_y, 0, screen_size.y))

func start_drag(item : RigidBody2D):
	thing_dragged = item
	if thing_dragged is Stubby:
		pass

func finish_drag(placing : bool):
	if thing_dragged:
		#thing_dragged.get_node("RigidBody2D").sleeping = false
		thing_dragged = null;
		
	
