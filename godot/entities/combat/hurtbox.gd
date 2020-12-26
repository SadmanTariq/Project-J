class_name Hurtbox
extends Area

signal health_changed(old_health, new_health)
signal died

export(float) var health setget _set_health
func _set_health(new_health):
	if health == new_health:
		return
	
	var old_health = health
	health = new_health
	emit_signal("health_changed", old_health, new_health)
	
	if health <= 0:
		emit_signal("died")

func _ready():
	add_to_group("hurtbox")
