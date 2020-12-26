class_name Hitbox
extends Area

signal hit

export(float) var damage

func _ready():
	add_to_group("hitbox")
	if !is_connected("area_entered", self, "_on_area_entered"):
		# warning-ignore:return_value_discarded
		connect("area_entered", self, "_on_area_entered")

func _on_area_entered(area: Area):
	if area.is_in_group("hurtbox"):
		area.health -= damage
		emit_signal("hit")
