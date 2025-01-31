extends Pickup
class_name Part

var value: int = 0

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		player.progression_manager.get_parts(value)
		die()
		await Values.display_number(value, "Part +",  Vector2(position.x, position.y), "#EB9035", null, false)
		queue_free()
	if area is Part and self is Part and not instant and uuid > area.uuid:
		area.value += value
		queue_free()
