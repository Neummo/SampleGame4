extends Control

@onready var panel: Panel = $Panel
@onready var button_1: TextureButton = $Panel/ItemButton
@onready var button_2: TextureButton = $Panel/ItemButton2
@onready var button_3: TextureButton = $Panel/ItemButton3
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
	Values.cant_unpause = true
	salvage_button.set_disabled(true)
	button_1.roll_card()
	button_2.roll_card()
	button_3.roll_card()
	while button_2.id == button_1.id:
		button_2.roll_card()
	while button_3.id == button_1.id or button_3.id == button_2.id:
		button_3.roll_card()
	panel.set_visible(true)
	get_tree().set_deferred("paused", true)

func deactivate() -> void:
	panel.set_visible(false)
	player.set_stats()
	salvage_button.set_disabled(false)
	if not priced:
		Values.item_count -= 1
		if Values.item_count > 0:
			activate()
			return
	else:
		priced = false
		pm.select_skill(salvage_button)
	Values.cant_unpause = false

func _on_item_pressed(id: int, icon: String) -> void:
	for child in list_panel.list.get_children():
		if child.id == id:
			child.increment()
			deactivate()
			return
	var counter = load("res://UI/OnScreenInfo/item_counter.tscn")
	var instance = counter.instantiate()
	instance.texture = ResourceLoader.load(icon)
	instance.id = id
	list_panel.list.add_child.call_deferred(instance)
	deactivate()

func _on_item_button_pressed() -> void:
	_on_item_pressed(button_1.id, button_1.icon_path)

func _on_item_button_2_pressed() -> void:
	_on_item_pressed(button_2.id, button_2.icon_path)

func _on_item_button_3_pressed() -> void:
	_on_item_pressed(button_3.id, button_3.icon_path)
