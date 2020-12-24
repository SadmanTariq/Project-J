extends Node2D

export var zoom_level = 1.0
const indicator_scene = preload("res://ui/minimap/minimap_indicator.tscn")

#var targets = []

func _ready():
	Globals.minimap = self
#	for t in get_tree().get_nodes_in_group('minimap_target'):
#		add_target(t)

func add_target(target):
	var indicator = indicator_scene.instance()
	indicator.target = target
	indicator.camera = $Camera
#	targets.append(t)
	add_child(indicator)
