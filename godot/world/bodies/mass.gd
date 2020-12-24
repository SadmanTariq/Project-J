class_name Mass
extends Spatial

const G = 6.6743
#const G = .000000000066743
export(float) var mass


func _ready():
	add_to_group("mass")

#func _big_g(x: float) -> float:
#	return 6.6743 * x * pow(10, -11)


func get_acceleration(position: Vector3) -> Vector3:
	var displacement = global_transform.origin - position
	var distance = displacement.length()
	return displacement.normalized() * get_acceleration_magnitude(distance)

func get_acceleration_magnitude(distance: float) -> float:
	return G * mass / pow(distance, 2)

func get_orbital_period(semimajor_axis: float) -> float:
	return sqrt(4 * PI * PI * pow(semimajor_axis, 3) / (G * mass))
