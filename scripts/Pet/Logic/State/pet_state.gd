extends Node
class_name PetState
## PetState acts as an abstract class for other states

var pet : Pet

func _init():
	if get_script() == PetState:
		push_error("PetState is abstract and should not be instantiated")

## sets up data before entering state 
func enter_state() -> void:
	push_error("Not implemented")

## called every frame
func handle_state() -> void:
	push_error("Not implemented")

## called when state is forcefully interrupted (by dragging or otherwise)
func interrupt() -> void:
	push_error("Not implemented")

## tearsdown data related to state
func exit_state() -> void:
	push_error("Not implemented")

## transitions this state to input state
func transition(next : PetState) -> void:
	exit_state()
	pet.set_state(next)
	next.enter_state()
	self.queue_free()
