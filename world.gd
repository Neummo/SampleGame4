extends Node2D

func pause() -> void:
	get_tree().set_deferred("paused", true)
	
func unpause() -> void:
	get_tree().set_deferred("paused", false)
