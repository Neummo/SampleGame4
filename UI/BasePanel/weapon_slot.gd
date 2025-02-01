extends TextureButton
class_name WeaponSlot

@export var weapon_tree: BigUpgradeTreeButton
@export var weapon_tree_2: BigUpgradeTreeButton
@export var weapon_tree_3: BigUpgradeTreeButton 
@export var weapon_tree_4: BigUpgradeTreeButton
@export var weapon_tree_5: BigUpgradeTreeButton
@export var id: int
@onready var weapon_list: HBoxContainer = $WeaponList

var weapons: Array
var trees: Array
var slot_weapon: BigUpgradeTreeButton
var elimination_count: Array = [50, 550, 1550, 3550]

func init() -> void:
	for child in weapon_list.get_children():
		weapon_list.remove_child(child)
		child.call_deferred("queue_free")
	trees = [
		weapon_tree, weapon_tree_2, weapon_tree_3,
		weapon_tree_4, weapon_tree_5,
	]
	weapons = Values.weapons
	for i in weapons.size():
		if weapons[i].unlocked.call() and not weapons[i].selected:
			var button = load("res://UI/BasePanel/weapon_button.tscn")
			var instance = button.instantiate()
			instance.icon_path = weapons[i].icon
			instance.tree = trees[i]
			instance.id = i
			weapon_list.add_child.call_deferred(instance)

func _on_pressed() -> void:
	if slot_weapon == null:
		weapon_list.visible = not weapon_list.visible

func _on_mouse_entered(description: RichTextLabel) -> void:
	description.set_text("Unlocks in " + str(elimination_count[Values.weapon_slots - 1] - Values.eliminations) + " eliminations")
	
func _on_mouse_exited(description: RichTextLabel) -> void:
	description.set_text("")
