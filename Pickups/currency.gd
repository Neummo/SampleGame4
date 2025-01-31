extends Pickup
class_name Currency

var value: float = 0.0

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		player.progression_manager.get_currency(value)
		die()
		await Values.display_number(snappedf(value, 0.01), "+",  Vector2(position.x, position.y), "#fff9d6", null, false)
		queue_free()
	if area is Currency and self is Currency and not instant and uuid > area.uuid:
		area.value += value
		queue_free()
