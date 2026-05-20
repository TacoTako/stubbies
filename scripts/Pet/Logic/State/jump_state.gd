extends PetState
class_name JumpState

var jump_force : int
var jump_direction : Vector2

var launch_frames := 20

func _init(pet : Pet):
	self.pet = pet

## sets up data before entering state 
func enter_state() -> void:
	pet.state_label.text = "Jump"
	init_random_jump()
	
	pet.physics_material_override.friction = 0
	var vel = jump_direction.normalized() * jump_force
	pet.apply_central_impulse(vel)

## called every frame
func handle_state() -> void:
	if launch_frames < 15:
		pet.physics_material_override.friction = 1.0
	
	var normal = pet.last_contact_normal
	if launch_frames < 0 and normal != Vector2.ZERO:
		
		if abs(normal.y) > 0.7:
			transition(IdleState.new(pet))

		elif abs(normal.x) > 0.7:
			transition(ClingState.new(pet))
	
	launch_frames -= 1
	
## set destination to random spot on the ground within bounds
func init_random_jump() -> void:
	jump_direction = Vector2(randf_range(-0.1, 0.1), 1)
	jump_force = randi_range(5000,20000)

## called when state is forcefully interrupted (by dragging or otherwise)
func interrupt() -> void:
	exit_state()
	pass

## tearsdown data related to state
func exit_state() -> void:
	pet.physics_material_override.friction = 1.0
	pet.state_label.text = ""
