extends Pickup

var value: int = 0

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		Values.item_count += 1
		die()
		await Values.display_number(1, "Salvage +",  Vector2(position.x, position.y), "#4287f5", null, false)
		queue_free()
