class_name LerpTargetFocus
extends CameraControllerBase


@export var lead_speed: float = 20.0
@export var catchup_delay_duration: float = 5.0
@export var leash_distance: float = 12.0
@export var catchup_speed: float = 10.0
@export var follow_speed: float = 5.0


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
	var input_direction = Vector3(
	Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 0,
	Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	#Lerp towards the vessel when it is stationary
	if input_direction == Vector3.ZERO: 
		position = lerp_with_speed(position, vessel_position, catchup_speed * 10, delta)
	# Calculate the target position to lead (a little ahead)
	else:
		var lead_target_position = vessel_position + (input_direction * leash_distance)
		if distance_to_vessel <= leash_distance:
			position = lerp_with_speed(position, lead_target_position, lead_speed * 5, delta)
		else:
			position = lerp_with_speed(position, vessel_position, catchup_speed * 10, delta)
	super(delta)
		
	
func draw_logic():
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	var crosshair_size: float = 5.0 
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# Horizontal line
	immediate_mesh.surface_add_vertex(Vector3(-crosshair_size / 2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(crosshair_size / 2, 0, 0))
	# Vertical line
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
	
#Linear Interpolation with specified speed
func lerp_with_speed(current: Vector3, target: Vector3, speed: float, delta: float) -> Vector3:
	var direction = (target - current).normalized()
	var distance = current.distance_to(target)
	var step = min(speed * delta, distance)  # Move by speed, but not past the target
	return current + direction * step
