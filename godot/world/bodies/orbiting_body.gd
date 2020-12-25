class_name OrbitingBody
extends KinematicBody

export(float) var semimajor_axis
export(float, 0, 1) var eccentricity
export(float) var orbital_period
export(float, -180, 180) var inclination_degrees
export(float, 0, 360) var mean_anomaly_degrees
export(float, 0, 360) var argument_of_periapsis_degrees
export var period_from_parent = true

onready var mean_anomaly = deg2rad(mean_anomaly_degrees)
onready var inclination = deg2rad(inclination_degrees)
onready var argument_of_periapsis = deg2rad(argument_of_periapsis_degrees)
onready var parent: Spatial = get_node("..")

var radius: float setget , _get_radius
func _get_radius():
	return $Mesh.radius


func _ready():
	if period_from_parent and parent.has_node("Mass"):
		orbital_period = parent.get_node("Mass").get_orbital_period(semimajor_axis)
	transform.origin = _get_coords(mean_anomaly)

func _physics_process(delta):
	move_and_collide(_get_coords(mean_anomaly) - transform.origin)
	mean_anomaly = fmod(mean_anomaly + (2 * PI / orbital_period) * delta, PI * 2)

func _get_eccentric_anomaly(M):
	var E = M
	while true:
		var dE = (E - eccentricity * sin(E) - M)/(1 - eccentricity * cos(E))
		E -= dE
		if abs(dE) < pow(10, -6):
			return E

func _get_coords(M) -> Vector3:
	var E = _get_eccentric_anomaly(M)
	var P = semimajor_axis * (cos(E) - eccentricity)
	var Q = semimajor_axis * sin(E) * sqrt(1 - pow(eccentricity, 2))
#	return Vector3(P, 0, Q)
	var coords = Vector3()
	
	# rotate by argument of periapsis
	coords.x = cos(argument_of_periapsis) * P - sin(argument_of_periapsis) * Q
	coords.y = sin(argument_of_periapsis) * P + cos(argument_of_periapsis) * Q
	
	# rotate by inclination
	coords.z = sin(inclination) * coords.y
	coords.y = cos(inclination) * coords.y
	
	return coords
	
	# rotate by longitude of ascending node
	#var xtemp = x;
	#x = Math.cos(W) * xtemp - Math.sin(W) * y;
	#y = Math.sin(W) * xtemp + Math.cos(W) * y;
	
	
