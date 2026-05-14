extends Node2D
class_name RadialMenu

@export var radius := 120.0
@export var arc_degrees := 180.0

var is_open = false

var buttons : Array = []
var count := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button_node in get_children():
		buttons.append(button_node)
		connect_button(button_node)
		button_node.visible = false
	
	count = buttons.size()

func connect_button(button : RadialButton) -> void:
	button.connect("clicked", button_click)

func toggle() -> void:
	if is_open:
		hide_buttons()
		is_open = false
	else:
		show_buttons()
		is_open = true

func show_buttons() -> void:
	if count == 0:
		return
		
	var arc_radians = deg_to_rad(arc_degrees)
	for i in count:
		var button = buttons[i]
		
		 # Spread buttons evenly across the arc
		var t = 0.0 if count == 1 else float(i) / (count - 1)
		
		# Angle range centered around upward direction
		var angle = -PI / 2 + lerp(-arc_radians / 2, arc_radians / 2, t)
		
		var target_pos = Vector2(cos(angle), sin(angle)) * radius
		
		# Start from center
		button.position = Vector2.ZERO
		button.scale = Vector2.ZERO
		
		button.visible = true
		# Animate outward
		var tween = create_tween()
		tween.set_parallel(true)
		
		tween.tween_property(button, "position" ,target_pos, 0.25
			).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		
		tween.tween_property(button, "scale", Vector2.ONE, 0.2)
		tween.tween_interval(i * 0.03)

func hide_buttons() -> void:
	if count == 0:
		return
	
	for i in count:
		var button = buttons[i]
		# Animate outward
		var tween = create_tween()
		tween.set_parallel(true)
		
		tween.tween_property(button, "position" ,Vector2.ZERO, 0.25
			).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		
		tween.tween_property(button, "scale", Vector2.ZERO, 0.2)
		tween.tween_interval(i * 0.03)
	

func button_click(button : RadialButton) -> void :
	print(button.button_name)
