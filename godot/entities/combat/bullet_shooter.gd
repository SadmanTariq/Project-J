extends Spatial

export(PackedScene) var bullet_scene
export(float) var cooldown

func _ready():
	$Timer.wait_time = cooldown

func fire(velocity := Vector3()):
	if !$Timer.is_stopped():
		return
	var bullet = bullet_scene.instance()
	bullet.parent_velocity = velocity
	
	Globals.world.add_child(bullet)
	bullet.global_transform = global_transform
	$Timer.start()
