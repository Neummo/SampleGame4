extends TextureButton
class_name WeaponButton

@onready var weapon_slot: WeaponSlot = $"../.."
var id: int
var icon_path: String
var tree: BigUpgradeTreeButton
var on_click
var pm: Node2D

func _ready() -> void:
	pm = get_tree().get_first_node_in_group("pm")
	texture_normal = ResourceLoader.load(icon_path)

func _on_pressed() -> void:
	weapon_slot.slot_weapon = tree
	weapon_slot.slot_weapon.global_position.x = weapon_slot.global_position.x
	weapon_slot.slot_weapon.set_visible(true)
	weapon_slot.texture_normal = ResourceLoader.load(icon_path)
	weapon_slot.visible = false
	Values.weapons[id]["selected"] = true
	var slots = get_tree().get_nodes_in_group("Slots")
	for slot in slots:
		slot.init()

func _on_mouse_entered() -> void:
	pm.description.text = str(Values.btify_text(Values.weapons[id]["description"] + "\n" + ", ".join(Values.weapons[id]["tags"])))

func _on_mouse_exited() -> void:
	pm.description.text = ""
