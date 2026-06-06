extends PetState
class_name DragState
## PetState acts as an abstract class for other states

func _init(pet : Pet):
	set_process(false)
	self.pet = pet

## sets up data before entering state 
func enter_state() -> void:
	pet.set_forces(false)
	pet.sprite.anim("drag")
	pet.state_label.text = "Dragging"

## called every frame
func handle_state() -> void:
	pass

## called when state is forcefully interrupted (by dragging or otherwise)
func interrupt() -> void:
	pass

## tearsdown data related to state
func exit_state() -> void:
	pet.state_label.text = ""
