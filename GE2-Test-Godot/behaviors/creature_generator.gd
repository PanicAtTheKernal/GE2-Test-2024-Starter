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

func _process(delta):
	DebugDraw3D.draw_box(Vector3(0,0,0), Quaternion(Vector3.RIGHT, 0), Vector3(base_size, base_size, base_size), Color.WHITE)
	pass		

func _ready():
	if not Engine.is_editor_hint():		
		pass
		



