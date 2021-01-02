extends Button

onready var sound = $click

func _on_play_pressed():
	sound.play()
	


func _on_click_finished():
	background_load.load_scene("res://main_scenes/main_scene.tscn")
