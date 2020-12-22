extends Spatial

export(NodePath) var camera_path

func _ready():
	var camera = get_node(camera_path)
	$CameraAnchor.remote_path = $CameraAnchor.call("get_path_to", camera)

func _physics_process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		translate(Vector3(0, 0, -10 * delta))
