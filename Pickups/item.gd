extends Pickup

var value: int = 0

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		queue_free()
		player.item_select.activate()
