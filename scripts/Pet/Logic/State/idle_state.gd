extends PetState
class_name IdleState
## PetState acts as an abstract class for other states

func _init(pet : Pet):
	self.pet = pet

## sets up data before entering state 
func enter_state() -> void:
	pet.state_label.text = "Idling"

## called every frame
func handle_state() -> void:
	pass

## called when state is forcefully interrupted (by dragging or otherwise)
func interrupt() -> void:
	exit_state()
	pass

## tearsdown data related to state
func exit_state() -> void:
	pet.state_label.text = ""
