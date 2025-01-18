extends Pickup

var value: int = 0

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		player.progression_manager.get_modules(1)
		die()
		await Values.display_number(1, "Module +",  Vector2(position.x - 10, position.y - 30), "#d9e22f", null, false)
		queue_free()
