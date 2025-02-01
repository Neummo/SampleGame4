extends Pickup
class_name Item

var value: int = 0

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		player.progression_manager.get_salvages(value)
		die()
		await Values.display_number(value, "Salvage +",  Vector2(position.x, position.y), "#6A994E", null, false)
		call_deferred("queue_free")
	if area is Item and self is Item and not instant and uuid > area.uuid:
		area.value += value
		call_deferred("queue_free")
