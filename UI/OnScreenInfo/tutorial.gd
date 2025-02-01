extends Control

func _on_texture_button_pressed() -> void:
	set_visible(false)
	get_tree().set_deferred("paused", false)

func _on_timer_timeout() -> void:
	get_tree().set_deferred("paused", true)
	set_visible(true)
