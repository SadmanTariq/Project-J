extends Spatial

export var zoom_level = 0.5 setget _set_zoom_level
export var zoom_increment = 0.02
export var min_distance = 20
export var max_distance = 100

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				_set_zoom_level(zoom_level + zoom_increment)
				
			if event.button_index == BUTTON_WHEEL_DOWN:
				_set_zoom_level(zoom_level - zoom_increment)

func _set_zoom_level(new_zoom):
	zoom_level = clamp(new_zoom, 0, 1)
	$Camera.translation.z = max_distance - (max_distance - min_distance) * zoom_level
