class_name PositionLock
extends CameraControllerBase


func _ready() -> void:
	super()
	rotation_degrees = Vector3(-90, 0, 0)
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
		
	if !draw_camera_logic:
		draw_logic()
		
	global_position = target.global_position
	super(delta)

#Drawing the crosshair using the mesh instance
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	var crosshair_size: float = 5.0 
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#Vertical Lines
	immediate_mesh.surface_add_vertex(Vector3(-crosshair_size / 2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(crosshair_size / 2, 0, 0))
	#Horizontal Lines
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -crosshair_size / 2))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, crosshair_size / 2))
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	await get_tree().process_frame
	mesh_instance.queue_free()
