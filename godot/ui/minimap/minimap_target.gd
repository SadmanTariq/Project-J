extends Spatial

export var show_on_map = true
export var main = false
export(Texture) var texture
export var sprite_scale = 1.0
export(ShaderMaterial) var material

var position: Vector2 setget , _get_position
var orientation: float setget , _get_orientation


func _ready():
	if Globals.minimap == null:
		set_process(true)
		return
	Globals.minimap.add_target(self)

func _process(_delta):
	if Globals.minimap != null:
		Globals.minimap.add_target(self)
		set_process(false)

func _get_position():
	return Vector2(global_transform.origin.x, global_transform.origin.z)
	
func _get_orientation():
	return -global_transform.basis.get_euler().y
