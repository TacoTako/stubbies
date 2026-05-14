extends Node2D
class_name RadialMenu

@export var button_size := 40.0
@export var gap := 10.0

@export var start_radius := 100.0
@export var row_spacing := 70.0
@export var arc_degrees := 90.0
const fan_start := -PI / 2

var is_open = false

var buttons : Array = []
var count := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button_node in get_children():
		buttons.append(button_node)
		button_node.connect("clicked", connect_button)
		button_node.scale = Vector2.ZERO
	
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
		
	var remaining = buttons.size()
	var current_index = 0
	var row = 0
	
	var arc_radians = deg_to_rad(arc_degrees)
	while remaining > 0:
		var radius = start_radius + row * row_spacing
		
		# Arc length available in this row
		var arc_length = radius * arc_radians
		# Space needed per button
		var spacing = button_size + gap
		
		# How many fit on this row
		var row_capacity = max(1, floori(arc_length / spacing))
		var row_count = min(row_capacity, remaining)
		
		for i in row_count:
			var button = buttons[current_index]
			
			# Even distribution across arc
			var t = float(i + 0.5) / (row_count) if row_count < 3 else float(i) / (row_count - 1)
			
			var angle = fan_start + lerp(0.0, arc_radians, t)
			var target_pos = Vector2(cos(angle), sin(angle)) * radius
			
			button.position = Vector2.ZERO
			button.scale = Vector2.ZERO
			
			button.animate(target_pos, Vector2.ONE, Tween.EASE_OUT, i * 0.05)
			current_index += 1
			
		remaining -= row_count
		row += 1

func hide_buttons() -> void:
	if count == 0:
		return
	
	for i in count:
		var button = buttons[i]
		# Animate outward
		button.animate(Vector2.ZERO, Vector2.ZERO, Tween.EASE_IN, i * 0.05)

func button_click(button : RadialButton) -> void :
	print(button.button_name)
