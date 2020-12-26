extends Spatial

export var speed = 50
var parent_velocity: Vector3

func _physics_process(delta):
	global_translate((parent_velocity + -global_transform.basis.z * speed)
					 * delta)

func _on_Hitbox_hit():
	queue_free()
