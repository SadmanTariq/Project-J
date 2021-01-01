extends Button

onready var sound = $click

func _on_play_pressed() -> void:
	sound.play()
	


func _on_click_finished() -> void:
	get_tree().change_scene("res://main_scenes/main_scene.tscn")
