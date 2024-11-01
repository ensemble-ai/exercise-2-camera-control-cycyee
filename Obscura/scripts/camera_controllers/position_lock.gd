class_name PositionLock
extends CameraControllerBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	rotation_degrees = Vector3(-90, 0, 0)
	position = target.position
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
		
	if !draw_camera_logic:
		draw_logic()
		
	global_position = target.global_position
	super(delta)

func draw_logic() -> void:

	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	# Crosshair dimensions
	var crosshair_size: float = 5.0  # Adjust this size as needed

	# Drawing crosshair at the center of the viewport
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)

	# Horizontal line
	immediate_mesh.surface_add_vertex(Vector3(-crosshair_size / 2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(crosshair_size / 2, 0, 0))

	# Vertical line
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -crosshair_size / 2))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, crosshair_size / 2))

	immediate_mesh.surface_end()

	# Set material properties
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK

	add_child(mesh_instance)

	# Set the position of the crosshair at the center of the viewport
	# var viewport_size = get_viewport().size
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	# Remove the mesh after one frame
	await get_tree().process_frame
	mesh_instance.queue_free()
