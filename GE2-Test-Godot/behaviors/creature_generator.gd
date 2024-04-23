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
var cube_colours: Array[Color] = []

const max_colour = 255;

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
	if not Engine.is_editor_hint():	
		create_creature()	
		

func create_cube_locations():
	cube_positions.clear()
	cube_sizes.clear()
	cube_colours.clear()
	for i in range(length):
		# Need to convert the length to angle
		var current_angle = TAU/length
		var angle = sin((i+start_angle)*frequency)
		var new_size = remap(angle, 0, TAU, base_size, multiplier)
		var new_colour = remap(angle, 0, TAU, 0, max_colour)
		#var new_size = clamp(, 0, base_size)
		cube_positions.append(Vector3(new_size*i, 0, -(new_size/2)))
		cube_sizes.append(Vector3(new_size, new_size, new_size))
		cube_colours.append(Color(new_colour, 0, 0))

func create_creature():
	var creature = Node.new()
	var spine_animator = SpineAnimator.new()
	spine_animator.name = "SpineAnimator"
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
			var new_mat = StandardMaterial3D.new()
			new_mat.albedo_color = cube_colours[i]
			box.material = new_mat
			
		else:
			var prev_size = cube_sizes[i-1]
			var prev_pos = cube_positions[i-1]
			next_pos.x = prev_size.x + prev_pos.x + 0.1
			cube_positions[i] = next_pos
			# Creating the body part
			var new_body_part = body.instantiate() as CharacterBody3D
			var box = new_body_part.get_child(0)
			box.size = cube_sizes[i]
			new_body_part.position = next_pos
			var new_mat = StandardMaterial3D.new()
			new_mat.albedo_color = cube_colours[i]
			box.material = new_mat
			creature.add_child(new_body_part)
	add_child(creature)
	
	var spine_animator_child = creature.get_child(0)
	
	for child in creature.get_children():
		# Ingore the spine animator
		if child.name == "SpineAnimator":
			continue
		spine_animator_child.bonePaths.append(child.get_path())
	spine_animator_child.calculateOffsets()
