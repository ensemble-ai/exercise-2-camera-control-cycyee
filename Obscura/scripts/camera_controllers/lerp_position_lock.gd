class_name LerpPositionLock
extends CameraControllerBase


@export var follow_speed: float = 20.0
@export var catchup_speed: float = 5.0
@export var leash_distance: float = 5.0


func _ready() -> void:
	draw_camera_logic = true
	rotation_degrees = Vector3(-90, 0, 0)
	super()
	position = target.position

func _process(delta: float) -> void:
	if !current:
		return
		
	if !draw_camera_logic:
		draw_logic()
		
	var vessel_position = target.global_position
	var distance_to_vessel = position.distance_to(vessel_position)
	# If within leash distance, move towards the vessel at follow speed
	if distance_to_vessel <= leash_distance:
		position = lerp_with_speed(position, vessel_position, catchup_speed, delta)
	# Exceeds leash distance, catch up to vessel
	else:
		var target_speed = target.velocity.length()
		position = lerp_with_speed(position, vessel_position, max(target_speed + 20, follow_speed + 20), delta)
	super(delta)
	
	
func draw_logic():
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	var crosshair_size: float = 5.0  # Adjust this size as needed

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-crosshair_size / 2, 0, 0)) # Horizontal line
	immediate_mesh.surface_add_vertex(Vector3(crosshair_size / 2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -crosshair_size / 2)) 	# Vertical line
	immediate_mesh.surface_add_vertex(Vector3(0, 0, crosshair_size / 2))
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	await get_tree().process_frame
	mesh_instance.queue_free()
	
#Linear Interpolation with specified speed
func lerp_with_speed(current: Vector3, target: Vector3, speed: float, delta: float) -> Vector3:
	var direction = (target - current).normalized()
	var distance = current.distance_to(target)
	var step = min(speed * delta, distance)  # Move by speed, but not past the target
	return current + direction * step
