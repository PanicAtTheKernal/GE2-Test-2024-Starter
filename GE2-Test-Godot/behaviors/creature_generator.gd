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

var cube_positions = []
var cube_sizes = []

func _process(delta):
	for i in range(length):
		DebugDraw3D.draw_box(cube_positions[i], Quaternion(Vector3.RIGHT, 0), cube_sizes[i], Color.WHITE)
		

func _ready():
	if not Engine.is_editor_hint():		
		pass
	create_cube_locations()
		

func create_cube_locations():
	for i in range(length):
		# Need to convert the length to angle
		var new_size = sin((frequency*i)+start_angle)*base_size
		#var new_size = clamp(, 0, base_size)
		print(new_size)
		cube_positions.append(Vector3(1*i, 0, 0))
		cube_sizes.append(Vector3(new_size, new_size, new_size))

