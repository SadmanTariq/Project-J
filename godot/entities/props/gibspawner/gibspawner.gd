extends Spatial

signal spawn_finished
export(Array, Mesh) var gibs
const gib_scene = preload("res://entities/props/gibspawner/gib.tscn")

func spawn():
	for g in gibs:
		var gib = gib_scene.instance()
		gib.mesh = g
		Globals.world.add_child(gib)
		gib.global_transform = global_transform
	emit_signal("spawn_finished")
