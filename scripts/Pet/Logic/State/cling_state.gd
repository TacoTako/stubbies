extends PetState
class_name ClingState

var timer : Timer

var wall_normal : Vector2
const release_force := 100

func _init(pet : Pet):
	self.pet = pet

## sets up data before entering state 
func enter_state() -> void:
	pet.state_label.text = "Cling"
	
	timer = Timer.new()
	add_child(timer)
	
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	start_random_timer()
	
	wall_normal = pet.last_contact_normal
	pet.set_forces(false)

## called every frame
func handle_state() -> void:
	pet.timer_label.text = "%.2f" % timer.time_left #DEBUG

#################### Timer functions for random states ########################

func start_random_timer():
	timer.wait_time = randf_range(1.0, 2.0)
	timer.start()

func _on_timeout():
	
	pet.linear_velocity = wall_normal * release_force
	transition(FallState.new(pet))

## called when state is forcefully interrupted (by dragging or otherwise)
func interrupt() -> void:
	pass

## tearsdown data related to state
func exit_state() -> void:
	pet.set_forces(true)
	pet.timer_label.text = "" #DEBUG
	pet.state_label.text = ""
