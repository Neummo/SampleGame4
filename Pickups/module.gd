extends Pickup
class_name Module

var value: int = 0

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		player.progression_manager.get_modules(value)
		die()
		await Values.display_number(value, "Module +",  Vector2(position.x , position.y), "#3F7CAC", null, false)
		queue_free()
	if area is Module and self is Module and not instant and uuid > area.uuid:
		area.value += value
		queue_free()
