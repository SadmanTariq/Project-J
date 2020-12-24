extends MeshInstance

const min_size = 5.0
const max_size = 30.0
const min_mass = 625.0
const max_mass = 13500.0

#var shader = preload("res://world/bodies/planets/planet.shader")
var planet_material = preload("res://world/bodies/planets/material.tres")
var material: ShaderMaterial
var rng = RandomNumberGenerator.new()

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
	rotate_y(delta)

func _generate():
	var size = clamp(rng.randfn(0.5, 0.2), 0, 1)
	
	var new_scale = min_size + (max_size - min_size) * size
	transform = transform.scaled(Vector3(new_scale, new_scale, new_scale))
	$Mass.mass = min_mass + (max_mass - min_mass) * size
	
	material.set_shader_param("ocean_color",
							  Color.from_hsv(randf(), 1.0, randf()))
	material.set_shader_param("ground_color1",
							  Color.from_hsv(randf(), randf(), rand_range(.2, .4)))
	material.set_shader_param("ground_color2",
							  Color.from_hsv(randf(), randf(), rand_range(.2, .4)))
	material.set_shader_param("land_amount", rand_range(.3, .8))
	material.set_shader_param("ground_bias", rand_range(.3, .8))
	
	material.get_shader_param("ocean_noise").noise.seed = randi()
	material.get_shader_param("ground_noise").noise.seed = randi()
