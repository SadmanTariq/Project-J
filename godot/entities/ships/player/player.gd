extends KinematicBody

export var max_rotation_speed = 180  # Degrees per second
export var max_bank_angle = 60  # Degrees
export(float, 0, 3) var rotation_factor: float


func _physics_process(delta):
	_rotate(delta)
	

func _rotate(delta):
	var forward: Vector3 = -transform.basis.z
	
	var angle_to_mouse = forward.angle_to(_get_rotate_target())
	angle_to_mouse *= sign(forward.cross(_get_rotate_target()).y)
	
	var amount = pow(sin(abs(angle_to_mouse) / 2), rotation_factor)
	amount *= sign(angle_to_mouse)
	
	var rotate_angle = amount * deg2rad(max_rotation_speed) * delta
	
	rotate_y(rotate_angle)
	rotation.z = amount * deg2rad(max_bank_angle)

func _get_rotate_target() -> Vector3:
	var mousepos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera()
	var rayorigin = camera.project_ray_origin(mousepos)
	var mouseray = camera.project_ray_normal(mousepos)
	var pos = rayorigin + (-rayorigin.y / mouseray.y) * mouseray
	return pos
