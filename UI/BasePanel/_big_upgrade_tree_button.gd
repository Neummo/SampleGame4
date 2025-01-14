extends TextureButton
class_name BigUpgradeTreeButton

@export var price_label: Label
@export var max_level: int
@onready var panel: Panel = $Panel
@onready var label: Label = $MarginContainer/Label
@onready var line: Line2D = $Line2D
@export var description: String

var description_panel: RichTextLabel
var unlocked: bool = true
var price: int
var prices
var maxed: bool = false
var level: int = 0:
	set(value):
		level = value
		if max_level > 1:
			label.text = str(level) + "/" + str(max_level)
		else:
			label.text = ""

func _ready() -> void:
	description_panel = get_tree().get_first_node_in_group("Description")
	if max_level > 1:
		label.text = "0/" + str(max_level)
	else:
		label.text = ""
	if get_parent() is BigUpgradeTreeButton:
		unlocked = false
		visible = false

func _process(_delta: float) -> void:
	if get_parent() is BigUpgradeTreeButton:
		line.clear_points()
		line.add_point(global_position + size / 2)
		line.add_point(get_parent().global_position + size / 2)

func check_price() -> void:
	var parent = get_parent()
	if parent is BigUpgradeTreeButton and parent.level > 0:
		visible = true
	if Values.currency < price or maxed or not unlocked:
		set_disabled(true)
	else:
		set_disabled(false)

func on_select() -> void:
	Values.currency -= price
	Values.update_saved_currency(price)
	if prices is Array:
		price = prices[level - 1]
		price_label.set_text(str(price))
	if level == max_level and max_level > 0:
		lock("Max upgrades")

func lock(_new_label_text: String) -> void:
	maxed = true
	price_label.set_text("")
	set_disabled(true)

func set_properties(_price: int, _prices) -> void:
	price = _price
	prices = _prices
	if price == 0:
		price_label.set_text("")
	else:
		price_label.set_text(str(price))

func _on_pressed() -> void:
	level = min(level + 1, max_level)
	panel.show_behind_parent = true
	line.default_color = Color(1, 1, 1)
	
	var skills = get_children()
	for skill in skills:
		if skill is BigUpgradeTreeButton and level == max_level:
			skill.unlocked = true

func _on_mouse_entered() -> void:
	if unlocked:
		description_panel.set_text(description)

func _on_mouse_exited() -> void:
	description_panel.set_text("")
