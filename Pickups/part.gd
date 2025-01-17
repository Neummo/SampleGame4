extends Pickup

var value: int = 0

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		player.progression_manager.get_parts(1)
		die()
		await Values.display_number(1, "Part +",  Vector2(position.x - 10, position.y - 30), "#8ae346", null, false)
		queue_free()
