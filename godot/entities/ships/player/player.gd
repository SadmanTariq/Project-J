extends RigidBody

export var max_rotation_speed = 180  # Degrees per second
export var max_bank_angle = 60  # Degrees
export(float, 0, 3) var rotation_factor: float
export var thrust = 150.0
#export var damping = 2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
#	print($Ship.global_transform.basis.get_euler().y)
#	translation.y = 0
#	linear_velocity.y = 0
	_rotate(delta)
#	_apply_weight(delta)
	if Input.is_action_pressed("accelerate"):
		_apply_thrust(delta)

func _apply_weight(delta):
	var a = Vector3()
	for m in get_tree().get_nodes_in_group("mass"):
		a += m.get_acceleration(global_transform.origin)
	a.y = 0
	apply_central_impulse(a * mass * delta)

func _apply_thrust(delta):
	var resultant = -transform.basis.z * thrust * delta
	resultant.y = 0
	apply_central_impulse(resultant)

func _rotate(delta):
	var forward: Vector3 = -transform.basis.z
	
	var rotate_target = _get_rotate_target()
	
	var angle_to_mouse = forward.angle_to(rotate_target)
	angle_to_mouse *= sign(forward.cross(rotate_target).y)
	
	var amount = pow(sin(abs(angle_to_mouse) / 2), rotation_factor)
	amount *= sign(angle_to_mouse)
	
#	var rotate_angle = amount * deg2rad(max_rotation_speed) * delta
#	rotate_y(rotate_angle)

	angular_velocity.y = amount * deg2rad(max_rotation_speed)
	$Ship.rotation.z = amount * deg2rad(max_bank_angle)

func _get_rotate_target() -> Vector3:
	if Globals.camera == null:
		return Vector3()
	return Globals.camera.get_world_global_mouse_pos() - global_transform.origin
