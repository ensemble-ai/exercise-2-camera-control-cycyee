class_name AutoScroll
extends CameraControllerBase


@export var top_left: Vector2  
@export var bottom_right: Vector2  
@export var autoscroll_speed: Vector3  


func _ready() -> void:
	rotation_degrees = Vector3(-90, 0, 0)
	draw_camera_logic = true
	position = target.position
	super()


func _process(delta: float) -> void:
	if !current:
		return
		
	if draw_camera_logic:
		draw_logic()
	#Logic for restricting the target to within the box
	var vessel_pos = target.global_position
	position.x += autoscroll_speed.x * delta
	position.z += autoscroll_speed.z * delta
	if vessel_pos.x < top_left.x + position.x:
		target.global_position.x = top_left.x + position.x
	if vessel_pos.z < bottom_right.y + position.z:
		target.global_position.z = bottom_right.y + position.z
	if vessel_pos.x > bottom_right.x + position.x:
		target.global_position.x = bottom_right.x + position.x
	if vessel_pos.z > top_left.y + position.z:
		target.global_position.z = top_left.y + position.z
	super(delta)
	
#Draws the box that restricts the target, including the edges that push it along
func draw_logic():
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	var adjusted_top_left = Vector3(top_left.x, position.y, top_left.y)
	var adjusted_bottom_right = Vector3(bottom_right.x, position.y, bottom_right.y)

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
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

	await get_tree().process_frame
	mesh_instance.queue_free()
