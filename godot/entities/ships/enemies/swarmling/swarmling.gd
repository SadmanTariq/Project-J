extends Spatial

export(String) var swarm_group
export var coherence = 0.005
export var separation = 0.05
export var separation_distance = 1.0
export var alignment = 0.05
export var max_speed = 150.0
export var engagement = 0.1
export var engagement_range = 50.0
export var stopping = 0.15
export var stopping_range = 10.0

#var target: Spatial
var velocity = Vector3()

func _ready():
	add_to_group(swarm_group)

func _physics_process(delta):
	_avoid_others()
	_fly_towards_center()
	_match_velocity()
	_to_target()
	_stop()
	
	velocity.y = 0
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	translate(velocity * delta)
	translation.y = 0
	
	$Ship.rotation.y = atan(velocity.x / velocity.z)
#	move_and_slide(velocity)

func _fly_towards_center():
	var center = Vector3()
	var num = 0
	
	for s in get_tree().get_nodes_in_group(swarm_group):
		center += s.global_transform.origin
		num += 1
	
	center /= num
	velocity += (center - global_transform.origin) * coherence
	
func _avoid_others():
	var move = Vector3()
	for s in get_tree().get_nodes_in_group(swarm_group):
		if s != self:
			if global_transform.origin.distance_to(s.global_transform.origin) <= separation_distance:
				move += global_transform.origin - s.global_transform.origin
	
	velocity += move * separation

func _match_velocity():
	var avg_vel = Vector3()
	var num = 0
	
	for s in get_tree().get_nodes_in_group(swarm_group):
		avg_vel += s.velocity
		num += 1
	
	avg_vel /= num
	velocity += avg_vel * alignment

func _to_target():
	for t in get_tree().get_nodes_in_group("swarm_target"):
		var to_target = t.global_transform.origin - global_transform.origin
		if to_target.length() <= engagement_range:
			velocity += to_target * engagement

func _stop():
	for t in get_tree().get_nodes_in_group("swarm_target"):
		var to_target = global_transform.origin - t.global_transform.origin
		if to_target.length() <= stopping_range:
			velocity += to_target * stopping
