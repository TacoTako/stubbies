extends AnimatedSprite2D
class_name AnimationManager

var facing_right := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim("sit")
	pass # Replace with function body.

func update_direction(facing : bool) -> void:
	facing_right = facing
	flip_h = facing_right

func anim(anim_name) -> void:
	if (is_playing()):
		stop()
	flip_h = facing_right
	play(anim_name)

func default_anim() -> void:
	anim("stand")
