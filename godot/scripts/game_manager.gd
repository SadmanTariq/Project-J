extends Node

var star_scene = preload("res://world/bodies/star/star.tscn")
var planet_scene = preload("res://world/bodies/planets/planet.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _input(event):
	if event.is_action_pressed("shoot"):
		spawn_system(Vector3())


func generate_system():
	var star = star_scene.instance()
	star.generate()
	
	var num_planets = max(int(rng.randfn(5, 3)), 1)
	
	for i in range(num_planets):
		var planet = planet_scene.instance()
		planet.semimajor_axis = star.radius * (10 + i * 3)
		planet.eccentricity = clamp(rng.randfn(0.4, 0.2), 0.0, 0.7)
		planet.inclination_degrees = [90, -90][rng.randi_range(0, 1)]
#		planet.orbital_period = 10
		planet.mean_anomaly = rng.randf_range(0, PI)
		planet.get_node("Mesh").generate()
		
		star.add_child(planet)
	
	return star

func spawn_system(position: Vector3):
	var system = generate_system()
	Globals.world.add_child(system)
	system.global_transform.origin = position
