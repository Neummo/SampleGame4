extends TextureButton

@onready var weapon_display: Control = $"../WeaponDisplay"
@onready var part_display: Control = $"../PartDisplay"
@onready var display_toggle_label: Label = $"../DisplayToggleLabel"

func _ready() -> void:
	part_display.set_visible(false)
	part_display.set_process(false)

func _on_pressed() -> void:
	if weapon_display.is_visible() and not part_display.is_visible():
		display_toggle_label.set_text("Weapon Upgrades")
		weapon_display.set_visible(false)
		weapon_display.set_process(false)
		part_display.set_visible(true)
		part_display.set_process(true)
		part_display.check_prices()
	else:
		display_toggle_label.set_text("Part Upgrades")
		weapon_display.set_visible(true)
		weapon_display.set_process(true)
		part_display.set_visible(false)
		part_display.set_process(false)
