extends Node2D
class_name World

func pause() -> void:
	get_tree().set_deferred("paused", true)
	
func unpause() -> void:
	get_tree().set_deferred("paused", false)
