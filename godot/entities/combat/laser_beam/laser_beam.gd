extends Spatial

const despawn_margin = 50  # pixels

export var speed = 50
var parent_velocity: Vector3

func _process(_delta):
	if !$DespawnTimer.is_stopped():
		return
	var view_pos = Globals.camera.unproject_position(global_transform.origin)
	var vp_size = get_viewport().size
	if (view_pos.x - vp_size.x > despawn_margin
			or view_pos.x < -despawn_margin
			or view_pos.y - vp_size.y > despawn_margin
			or view_pos.y < -despawn_margin):
		queue_free()

func _physics_process(delta):
	global_translate((parent_velocity + -global_transform.basis.z * speed)
					 * delta)

func _on_Hitbox_hit():
	queue_free()

func _on_Hitbox_body_entered(_body):
	queue_free()
