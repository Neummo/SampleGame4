extends PartUpgradeButtonInterface
class_name PartUpgradeButton

var effect

func _on_pressed() -> void:
	on_select()
	effect.call()
	player.set_stats()

func _on_mouse_entered() -> void:
	hover()

func _on_mouse_exited() -> void:
	unhover()
