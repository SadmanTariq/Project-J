extends Area

const mean_size = 75.0
const mean_mass = 93750.0
const standard_deviation = 0.1

var radius = 0.0

func generate():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var multiplier = clamp(rng.randfn(1.0, 0.3), 0.1, 2.0)
	$Mass.mass = mean_mass * multiplier
	radius = mean_size * multiplier
	$Mesh.transform = $Mesh.transform.scaled(Vector3(radius, radius, radius))
