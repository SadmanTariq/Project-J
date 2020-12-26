extends MeshInstance

const min_size = 25.0
const max_size = 60.0
const min_mass = 625.0
const max_mass = 13500.0

#const mean_size = 30.0
#const mean_mass = 600.0
#const standard_deviation = 0.1

#var shader = preload("res://world/bodies/planets/planet.shader")
var planet_material = preload("res://world/bodies/planets/material.tres")
var material: ShaderMaterial
var rng = RandomNumberGenerator.new()

var radius: float
#var color1: Color
#var color2: Color
var angular_velocity: float
var rotation_axis: Vector3

func generate():
	rng.randomize()
	
	material = planet_material.duplicate(true)
#	material.set_shader_param("ocean_noise",
#		material.get_shader_param("ocean_noise").duplicate(true))
#	material.set_shader_param("ground_noise",
#		material.get_shader_param("ground_noise").duplicate(true))
	material_override = material
	_generate()

#func _input(event):
#	if event.is_action_pressed("accelerate"):
#		_generate()

func _process(delta):
	rotate_y(angular_velocity * delta)

func _generate():
	radius = clamp(rng.randfn(0.5, 0.2), 0, 1)
	angular_velocity = rng.randf_range(0.2 * PI, PI) * [-1, 1][rng.randi_range(0, 1)]

	var new_scale = min_size + (max_size - min_size) * radius
	transform = transform.scaled(Vector3(new_scale, new_scale, new_scale))
	get_node("../Mass").mass = min_mass + (max_mass - min_mass) * radius
	
#	var size = rng.randfn(1.0, standard_deviation)
#	radius = mean_size * size
#	get_node("../Mass").mass = mean_mass * size
	
	var ocean_color = Color.from_hsv(randf(), 1.0, randf())
	var ground_color1 = Color.from_hsv(randf(), randf(), rand_range(.2, .4))
	var ground_color2 = Color.from_hsv(randf(), randf(), rand_range(.2, .4))
	
	material.set_shader_param("ocean_color", ocean_color)
	material.set_shader_param("ground_color1", ground_color1)
	material.set_shader_param("ground_color2", ground_color2)
	material.set_shader_param("land_amount", rand_range(.3, .8))
	material.set_shader_param("ground_bias", rand_range(.3, .8))
	
	material.get_shader_param("ocean_noise").noise.seed = randi()
	material.get_shader_param("ground_noise").noise.seed = randi()
	
#	color2 = ocean_color
#	color1 = ground_color1
	
	var icon_material = get_node("../MinimapTarget").material.duplicate()
	icon_material.set_shader_param("color1", ground_color1)
	icon_material.set_shader_param("color2", ocean_color)
	get_node("../MinimapTarget").material = icon_material
