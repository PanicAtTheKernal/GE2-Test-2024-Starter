@tool
extends Node3D

@export
var length: int = 20
@export
var start_angle: float = 0
@export
var frequency: float = 1
@export
var base_size: float = 1
@export
var multiplier: float = 5

var cube_positions: Array[Vector3] = []
var cube_sizes = []

func _process(delta):
	for i in range(length):
		var next_pos = cube_positions[i]
		# Head Logic
		if i == 0:
			pass
		else:
			var prev_size = cube_sizes[i-1]
			var prev_pos = cube_positions[i-1]
			next_pos.x = prev_size.x + prev_pos.x
			
		DebugDraw3D.draw_box(next_pos, Quaternion(Vector3.RIGHT, 0), cube_sizes[i], Color.WHITE)
		

func _ready():
	if not Engine.is_editor_hint():		
		pass
	create_cube_locations()
		

func create_cube_locations():
	for i in range(length):
		# Need to convert the length to angle
		var angle = sin((frequency*i)+start_angle)
		var new_size = remap(angle, 0, TAU, base_size, multiplier)
		#var new_size = clamp(, 0, base_size)
		print(new_size)
		cube_positions.append(Vector3(new_size*i, 0, -(new_size/2)))
		cube_sizes.append(Vector3(new_size, new_size, new_size))

