extends Control

@onready var panel_animator: AnimatedSprite2D = $panel_animator
@onready var button_1: TextureButton = $ItemButton
@onready var button_2: TextureButton = $ItemButton2
@onready var button_3: TextureButton = $ItemButton3
var list_panel: Control
var player: CharacterBody2D
var priced: bool = false
var salvage_button: UpgradeButton
var pm: Node2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	list_panel = get_tree().get_first_node_in_group("ItemList")
	salvage_button = get_tree().get_first_node_in_group("SalvageButton")
	pm = get_tree().get_first_node_in_group("pm")

func activate() -> void:
	panel_animator.set_visible(true)
	#salvage_button.set_disabled(true)
	button_1.roll_card()
	button_2.roll_card()
	button_3.roll_card()
	while button_2.id == button_1.id:
		button_2.roll_card()
	while button_3.id == button_1.id or button_3.id == button_2.id:
		button_3.roll_card()
	set_visible(true)
	get_tree().set_deferred("paused", true)

func deactivate() -> void:
	player.set_stats()
	salvage_button.set_disabled(false)
	if not priced:
		Values.item_count -= 1
		panel_animator.play("appear")
		await panel_animator.animation_finished
		if Values.item_count > 0:
			panel_animator.play("disappear")
			activate()
			return
	else:
		priced = false
		pm.select_skill(salvage_button)
	pm.update_item_button()
	get_tree().set_deferred("paused", false)
	panel_animator.stop()
	panel_animator.set_visible(false)
	set_visible(false)

func _on_item_pressed(id: int, icon: String, rarity: int) -> void:
	if increment_item(list_panel.list1.get_children(), id):
		return
	if increment_item(list_panel.list2.get_children(), id):
		return
	if increment_item(list_panel.list3.get_children(), id):
		return
	
	var counter = load("res://UI/OnScreenInfo/item_counter.tscn")
	var instance = counter.instantiate()
	instance.texture = ResourceLoader.load(icon)
	instance.id = id
	if rarity == 0:
		list_panel.list1.add_child.call_deferred(instance)
		list_panel.line1.set_visible(true)
	elif rarity == 1:
		list_panel.list2.add_child.call_deferred(instance)
		list_panel.line2.set_visible(true)
	elif rarity == 2:
		list_panel.list3.add_child.call_deferred(instance)
		list_panel.line3.set_visible(true)
	deactivate()

func increment_item(list: Array[Node], id: int) -> bool:
	for child in list:
		if not child is Panel and child.id == id:
			child.increment()
			deactivate()
			return true
	return false
	
func _on_item_button_pressed() -> void:
	_on_item_pressed(button_1.id, button_1.icon_path, button_1.rarity)

func _on_item_button_2_pressed() -> void:
	_on_item_pressed(button_2.id, button_2.icon_path, button_2.rarity)

func _on_item_button_3_pressed() -> void:
	_on_item_pressed(button_3.id, button_3.icon_path, button_3.rarity)
