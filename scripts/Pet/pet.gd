extends DraggableObject
class_name Pet

@onready var sprite := $Sprite
@onready var state : PetState = FallState.new(self)
@onready var menu := $RadialMenu
@onready var state_label := $Sprite/StateDebug
@onready var timer_label := $Sprite/TimerDebug


@export var squash_strength := 2.4

var original_scale := 0.465
var target_scale := Vector2.ONE

var last_contact_normal := Vector2.ZERO

func _ready():
	super._ready()
	state.enter_state()
	pass

func _input(event):
	super._input(event)
	if event.is_action_pressed("rightMouseClick") and !dragging:
		menu.toggle()

func _process(delta):
	# Squash/Stretch code
	sprite.scale = scale.lerp(target_scale, delta * 15.0)  * original_scale
	# Slowly return to normal size
	target_scale = target_scale.lerp(Vector2.ONE, delta * 10.0)
	if state:
		state.handle_state()

func _physics_process(delta):
	super._physics_process(delta)
	if dragging:
		sprite.update_direction(tracked_velocity.x < 0)
		rotation = lerp_angle(
			rotation,
			tracked_velocity.x * 0.0005, # tweak this value
			10.0 * delta
		)
		
func _integrate_forces(state):
	if state.get_contact_count() > 0:
		last_contact_normal = state.get_contact_local_normal(0)
	else:
		last_contact_normal = Vector2.ZERO
		return

	for i in state.get_contact_count():
		var normal = state.get_contact_local_normal(i)

		# Floor / ceiling hit
		if abs(normal.y) > 0.7:
			squash(linear_velocity.y, false)

		# Wall hit
		elif abs(normal.x) > 0.7:
			squash(linear_velocity.x, true)

		# Only trigger once per frame
		break

func set_state(new_state : PetState) -> void:
	if self.state:
		self.state.queue_free()
	self.state = new_state
	if !(new_state is IdleState):
		menu.force_hide()
	
	add_child(new_state)
	state.enter_state()

func start_drag() -> void:
	super.start_drag()
	state.interrupt()
	state.transition(DragState.new(self))
	lock_rotation = false

func finish_drag() -> void:
	super.finish_drag()
	state.transition(FallState.new(self))
	lock_rotation = true
	rotation = 0

func squash(force : float, vertical : bool) -> void:
	# normalize force
	force = clamp(abs(force) / 1200.0, 0.0, 1.0)
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
