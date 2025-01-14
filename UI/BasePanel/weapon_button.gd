extends TextureButton
class_name WeaponButton

@onready var weapon_slot: WeaponSlot = $"../.."
var id: int
var icon_path: String
var tree: BigUpgradeTreeButton
var on_click

func _ready() -> void:
	texture_normal = ResourceLoader.load(icon_path)

func _on_pressed() -> void:
	weapon_slot.slot_weapon = tree
	weapon_slot.slot_weapon.global_position.y = weapon_slot.global_position.y
	weapon_slot.slot_weapon.set_visible(true)
	weapon_slot.texture_normal = ResourceLoader.load(icon_path)
	weapon_slot.weapon_list.visible = false
	Values.weapons[id]["selected"] = true
	var slots = get_tree().get_nodes_in_group("Slots")
	for slot in slots:
		slot.init()
