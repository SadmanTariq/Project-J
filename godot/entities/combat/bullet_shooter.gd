extends Spatial

export(PackedScene) var bullet_scene
export(float) var cooldown
export var randomize_cooldown = false
export var cooldown_sd = 0.0
export var cancel_perp_component = false

var target: Spatial
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	if randomize_cooldown:
		$Timer.wait_time = rng.randfn(cooldown, cooldown_sd)
	else:
		$Timer.wait_time = cooldown

func fire(velocity := Vector3()):
	if target != null:
		look_at(target.global_transform.origin, Vector3.UP)
	if !$Timer.is_stopped():
		return
	
	var bullet = bullet_scene.instance()
	
	if cancel_perp_component:
		var to_target = -global_transform.basis.z
		bullet.parent_velocity = velocity.dot(to_target) * to_target
	else:
		bullet.parent_velocity = velocity
	
	Globals.world.add_child(bullet)
	bullet.global_transform = global_transform
	
	if randomize_cooldown:
		$Timer.start(rng.randfn(cooldown, cooldown_sd))
	else:
		$Timer.start()
