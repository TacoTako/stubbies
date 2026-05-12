extends PetState
class_name FallState
## PetState acts as an abstract class for other states

func _init(pet : Pet):
	self.pet = pet

## sets up data before entering state 
func enter_state() -> void:
	pet.state_label.text = "Falling"

## called every frame
func handle_state() -> void:
	if pet.linear_velocity.length() == 0:
		transition(IdleState.new(pet))

## called when state is forcefully interrupted (by dragging or otherwise)
func interrupt() -> void:
	exit_state()
	pass

## tearsdown data related to state
func exit_state() -> void:
	pet.state_label.text = ""
