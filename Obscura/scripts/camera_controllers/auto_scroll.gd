class_name AutoScroll
extends CameraControllerBase

@export var top_left: Vector2  # Top left corner of the frame border box
@export var bottom_right: Vector2  # Bottom right corner of the frame border box
@export var autoscroll_speed: Vector3  # Speed of autoscrolling along x and z axes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_degrees = Vector3(-90, 0, 0)
	draw_camera_logic = true
	position = target.position
	super()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return

	if !draw_camera_logic:
		draw_logic()  
	position.x += autoscroll_speed.x * delta
	position.z += autoscroll_speed.z * delta

	#Boundary push logic for the vessel, only for the left and bottom edges
	var vessel_pos = target.global_position
	if vessel_pos.x < top_left.x + position.x:
		target.global_position.x = top_left.x + position.x
	elif vessel_pos.z < bottom_right.y + position.z:
		target.global_position.z = bottom_right.y + position.z
#
	## Allow free movement within the box, preventing movement beyond the box's top and right edges
	if vessel_pos.x > bottom_right.x + position.x:
		target.global_position.x = bottom_right.x + position.x
	if vessel_pos.z > top_left.y + position.z:
		target.global_position.z = top_left.y + position.z
		
	super(delta)

func draw_logic():
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	# Define the box corners relative to the camera’s current position
	var adjusted_top_left = Vector3(top_left.x, position.y, top_left.y)
	var adjusted_bottom_right = Vector3(bottom_right.x, position.y, bottom_right.y)

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)

	# Draw lines to form the box
	immediate_mesh.surface_add_vertex(Vector3(adjusted_top_left.x, 0, adjusted_top_left.z))
	immediate_mesh.surface_add_vertex(Vector3(adjusted_bottom_right.x, 0, adjusted_top_left.z))

	immediate_mesh.surface_add_vertex(Vector3(adjusted_bottom_right.x, 0, adjusted_top_left.z))
	immediate_mesh.surface_add_vertex(Vector3(adjusted_bottom_right.x, 0, adjusted_bottom_right.z))

	immediate_mesh.surface_add_vertex(Vector3(adjusted_bottom_right.x, 0, adjusted_bottom_right.z))
	immediate_mesh.surface_add_vertex(Vector3(adjusted_top_left.x, 0, adjusted_bottom_right.z))

	immediate_mesh.surface_add_vertex(Vector3(adjusted_top_left.x, 0, adjusted_bottom_right.z))
	immediate_mesh.surface_add_vertex(Vector3(adjusted_top_left.x, 0, adjusted_top_left.z))

	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK

	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(position.x, target.global_position.y, position.z)

	# Free the mesh after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
