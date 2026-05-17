extends PetState
class_name WalkState

var speed := 100
var destination : Vector2

func _init(pet : Pet):
	self.pet = pet

## sets up data before entering state 
func enter_state() -> void:
	pet.state_label.text = "Walking"
	get_random_dest()

## called every frame
func handle_state() -> void:
	var direction = destination - pet.global_position
	
	if direction.length() < 5.0:
		pet.linear_velocity = Vector2.ZERO
		transition(IdleState.new(pet))
		return
	
	pet.linear_velocity = direction.normalized() * speed

## set destination to random spot on the ground within bounds
func get_random_dest() -> void:
	var rand_x = randf_range(0 + pet.y_margin, ScreenSize.screen_size.y - pet.y_margin)
		
	destination = Vector2(rand_x, pet.position.y)

## called when state is forcefully interrupted (by dragging or otherwise)
func interrupt() -> void:
	exit_state()
	pass

## tearsdown data related to state
func exit_state() -> void:
	pet.state_label.text = ""
