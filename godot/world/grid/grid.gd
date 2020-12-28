extends CSGMesh

export var divisions = 50 setget _set_divisions
func _set_divisions(value):
	divisions = value
	material.set_shader_param("divisions", divisions)

var size: Vector2
var offset: Vector3

func _ready():
	size = mesh.size
	offset = _get_camera_center()
	material.set_shader_param("divisions", divisions)

func _process(_delta):
	global_transform.origin = _get_stepped_camera_center()

func _get_camera_center() -> Vector3:
	var camera = get_viewport().get_camera()
	var view_center = get_viewport().size / 2
	var ray_origin = camera.project_ray_origin(view_center)
	var ray_normal = camera.project_ray_normal(view_center)
	return ray_origin + (-ray_origin.y / ray_normal.y) * ray_normal


func _get_stepped_camera_center() -> Vector3:
	var pos = _get_camera_center()
	pos.x = stepify(pos.x, size.x / divisions)
	pos.z = stepify(pos.z, size.y / divisions)
	return pos
