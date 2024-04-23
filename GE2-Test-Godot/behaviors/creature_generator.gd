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

func _process(delta):
	for cube in cube_positions:
		DebugDraw3D.draw_box(cube, Quaternion(Vector3.RIGHT, 0), Vector3(base_size, base_size, base_size), Color.WHITE)
	pass		

func _ready():
	if not Engine.is_editor_hint():		
		pass
	create_cube_locations()
		

func create_cube_locations():
	for i in range(length):
		cube_positions.append(Vector3(1*i, 0, 0))

