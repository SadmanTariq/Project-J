extends Node

var camera: Spatial
var world: Spatial
var minimap: Node2D
var player: RigidBody

func biased_randf(bias: float) -> float:
	# DONT USE THIS
	# THIS IS SHIT
	# USE RANDFN INSTEAD
	
	# bias = 1: uniform distribution
	# bias < 1: closer to the middle
	# bias > 1: closer to the start and end
	return pow(sin(PI * randf() / 2), bias)

func _ready():
	randomize()
