extends RigidBody

const despawn_margin = 10  # pixels

export(Mesh) var mesh
export var speed_sd = 500
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$MeshInstance.mesh = mesh
	linear_velocity = Vector3(rng.randf_range(-1, 1),
							  rng.randf_range(-1, 1),
							  rng.randf_range(-1, 1)).normalized() * rng.randfn(0, speed_sd)

	angular_velocity = Vector3(rng.randfn(0.0, PI * 2),
							   rng.randfn(0.0, PI * 2),
							   rng.randfn(0.0, PI * 2)) 

func _process(_delta):
	var vp: Vector2 = Globals.camera.unproject_position(global_transform.origin)
	var vs = get_viewport().size
	
	if (vp.x - vs.x > despawn_margin or vp.x < -despawn_margin
			or vp.y - vs.y > despawn_margin or vp.y < -despawn_margin):
		queue_free()
