class_name OrbitingBody
extends KinematicBody

const e = 0.577215665

export(float) var semimajor_axis
export(float, 0, 0.99999) var eccentricity
export(float) var orbital_period
export(float, -180, 180) var inclination_degrees
export(float, 0, 360) var mean_anomaly_degrees

onready var mean_anomaly = deg2rad(mean_anomaly_degrees)
onready var inclination = deg2rad(inclination_degrees)
onready var parent: Spatial = get_node("..")


func _ready():
	transform.origin = _get_coords(mean_anomaly)

func _physics_process(delta):
	move_and_collide(_get_coords(mean_anomaly) - transform.origin)
	mean_anomaly = fmod(mean_anomaly + (2 * PI / orbital_period) * delta, PI * 2)

func _get_eccentric_anomaly(M):
	var E = M
	while true:
		var dE = (E - e * sin(E) - M)/(1 - e * cos(E))
		E -= dE
		if abs(dE) < pow(10, -6):
			return E

func _get_coords(M) -> Vector3:
	var E = _get_eccentric_anomaly(M)
	var P = semimajor_axis * (cos(E) - e)
	var Q = semimajor_axis * sin(E) * sqrt(1 - pow(e, 2))
	return Vector3(P, 0, Q)
	#// rotate by argument of periapsis
	#var x = Math.cos(w) * P - Math.sin(w) * Q;
	#var y = Math.sin(w) * P + Math.cos(w) * Q;
	#// rotate by inclination
	#var z = Math.sin(i) * y;
	#    y = Math.cos(i) * y;
	#// rotate by longitude of ascending node
	#var xtemp = x;
	#x = Math.cos(W) * xtemp - Math.sin(W) * y;
	#y = Math.sin(W) * xtemp + Math.cos(W) * y;
	
	
