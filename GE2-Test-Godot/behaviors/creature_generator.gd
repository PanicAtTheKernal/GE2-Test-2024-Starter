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

@export
var head: PackedScene
@export
var body: PackedScene

var cube_positions: Array[Vector3] = []
var cube_sizes = []

func _process(delta):
	create_cube_locations()
	
	for i in range(length):
		var next_pos = cube_positions[i]
		# Head Logic
		if i == 0:
			pass
		else:
			var prev_size = cube_sizes[i-1]
			var prev_pos = cube_positions[i-1]
			next_pos.x = prev_size.x + prev_pos.x
			cube_positions[i] = next_pos
		DebugDraw3D.draw_box(next_pos, Quaternion(Vector3.RIGHT, 0), cube_sizes[i], Color.WHITE)
		

func _ready():
	create_cube_locations()	
	create_creature()
	if not Engine.is_editor_hint():	
		pass	
		

func create_cube_locations():
	cube_positions.clear()
	cube_sizes.clear()
	for i in range(length):
		# Need to convert the length to angle
		var current_angle = TAU/length
		var angle = sin(current_angle*i)+start_angle
		var new_size = remap(angle, 0, TAU, base_size, multiplier)
		#var new_size = clamp(, 0, base_size)
		cube_positions.append(Vector3(new_size*i, 0, -(new_size/2)))
		cube_sizes.append(Vector3(new_size, new_size, new_size))

func create_creature():
	var creature = Node.new()
	var spine_animator = SpineAnimator.new()
	creature.add_child(spine_animator)
	for i in range(length):
		var next_pos = cube_positions[i]
		# Head Logic
		if i == 0:
			var new_head = head.instantiate()
			# Head is the first child
			var box = new_head.get_child(0)
			box.size = cube_sizes[i]
			creature.add_child(new_head)
			spine_animator.bonePaths.append(new_head.get_path())
		else:
			pass
			#var prev_size = cube_sizes[i-1]
			#var prev_pos = cube_positions[i-1]
			#next_pos.x = prev_size.x + prev_pos.x
			#cube_positions[i] = next_pos
			#DebugDraw3D.draw_box(next_pos, Quaternion(Vector3.RIGHT, 0), cube_sizes[i], Color.WHITE)
	get_parent().add_child(Node.new())
	get_parent().print_tree()
	pass
