class_name SpeedupPushZone
extends CameraControllerBase

@export var push_ratio: float = 1.5
@export var pushbox_top_left: Vector2
@export var pushbox_bottom_right: Vector2
@export var speedup_zone_top_left: Vector2
@export var speedup_zone_bottom_right: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_degrees = Vector3(-90, 0, 0)
	position = target.position
	draw_camera_logic = true
	super()
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	if !draw_camera_logic:
		draw_logic()
	
	var target_position = target.global_position
	var target_velocity = target.velocity  # Assuming target has a velocity property
	var target_speed = target_velocity.length()  # Calculate the target speed
	var difference_vector = target.position - position
	if is_in_zone(target_position, speedup_zone_top_left, speedup_zone_bottom_right):
		#print("Deadzone")
		if draw_camera_logic:
			draw_logic()
		return  # Do not move the camera if in the speedup zone

	# Case 2: Inside the pushbox but not in the speedup zone -> move at push_ratio
	elif is_in_zone(target_position, pushbox_top_left, pushbox_bottom_right) and not is_in_zone(target_position, speedup_zone_top_left, speedup_zone_bottom_right):
		#print("Scaled Zone")
		# Move the camera based on target speed and push_ratio
		position = lerp_with_speed(position, target.position, target_speed * push_ratio, delta)
		#return  # Skip to avoid boundary checks when inside the inner box

	# Case 3: Touching the outer pushbox boundary -> constrain movement
	else:
		#print("Boundary touched")
		#print(position)
		# Define boundary edges based on pushbox dimensions
		var box_width = abs(pushbox_bottom_right.x - pushbox_top_left.x)
		var box_height = abs(pushbox_bottom_right.y - pushbox_top_left.y)
		var half_box_width = box_width / 2.0
		var half_box_height = box_height / 2.0
		
		# Calculate camera adjustments for each side if target is touching boundary
		var tpos = target.global_position
		var cpos = global_position
		var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - box_width / 2.0)
		if diff_between_left_edges < 0:
			global_position.x += diff_between_left_edges
		#right
		var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_width / 2.0)
		if diff_between_right_edges > 0:
			global_position.x += diff_between_right_edges
		#top
		var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - box_height / 2.0)
		if diff_between_top_edges < 0:
			global_position.z += diff_between_top_edges
		#bottom
		var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_height / 2.0)
		if diff_between_bottom_edges > 0:
			global_position.z += diff_between_bottom_edges
		
	super(delta)
		



func is_in_zone(pos: Vector3, top_left: Vector2, bottom_right: Vector2) -> bool:
	return pos.x >= position.x + top_left.x and pos.x <= position.x + bottom_right.x and pos.z <= position.z + top_left.y and pos.z >= position.z + bottom_right.y

func draw_logic():
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var push_box_right = pushbox_bottom_right.x
	var push_box_left = pushbox_top_left.x
	var push_box_top = pushbox_top_left.y
	var push_box_bottom = pushbox_bottom_right.y
	
	var speed_box_right = speedup_zone_bottom_right.x
	var speed_box_left = speedup_zone_top_left.x
	var speed_box_top = speedup_zone_top_left.y
	var speed_box_bottom = speedup_zone_bottom_right.y
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(push_box_right, 0, push_box_top))
	immediate_mesh.surface_add_vertex(Vector3(push_box_right, 0, push_box_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(push_box_right, 0, push_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(push_box_left, 0, push_box_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(push_box_left, 0, push_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(push_box_left, 0, push_box_top))
	
	immediate_mesh.surface_add_vertex(Vector3(push_box_left, 0, push_box_top))
	immediate_mesh.surface_add_vertex(Vector3(push_box_right, 0, push_box_top))
	immediate_mesh.surface_end()
	

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(speed_box_right, 0, speed_box_top))
	immediate_mesh.surface_add_vertex(Vector3(speed_box_right, 0, speed_box_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(speed_box_right, 0, speed_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(speed_box_left, 0, speed_box_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(speed_box_left, 0, speed_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(speed_box_left, 0, speed_box_top))
	
	immediate_mesh.surface_add_vertex(Vector3(speed_box_left, 0, speed_box_top))
	immediate_mesh.surface_add_vertex(Vector3(speed_box_right, 0, speed_box_top))
	immediate_mesh.surface_end()


	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
	
func lerp_with_speed(current: Vector3, target: Vector3, speed: float, delta: float) -> Vector3:
	var direction = (target - current).normalized()
	var distance = current.distance_to(target)
	var step = min(speed * delta, distance)  # Move by speed, but not past the target
	return current + direction * step
