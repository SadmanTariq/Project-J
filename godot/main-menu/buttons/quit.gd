extends Button

onready var sound = $click

func _on_quit_pressed() -> void:
	sound.play()


func _on_click_finished() -> void:
	get_tree().quit()
