extends PetState
class_name IdleState

var timer : Timer

func _init(pet : Pet):
	self.pet = pet

## sets up data before entering state 
func enter_state() -> void:
	pet.sprite.anim("stand")
	pet.state_label.text = "Idling"
	
	timer = Timer.new()
	add_child(timer)
	
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	start_random_timer()

## called every frame
func handle_state() -> void:
	pet.timer_label.text = "%.2f" % timer.time_left #DEBUG

#################### Timer functions for random states ########################

func start_random_timer():
	timer.wait_time = randf_range(1.0, 2.0)
	timer.start()

func _on_timeout():
	transition(JumpState.new(pet))

## called when state is forcefully interrupted (by dragging or otherwise)
func interrupt() -> void:
	pass

## tearsdown data related to state
func exit_state() -> void:
	pet.timer_label.text = "" #DEBUG
	pet.state_label.text = ""
