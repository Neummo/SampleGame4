extends TextureButton
class_name BigUpgradeButton

@export var label: Label
@export var price_label: Label

var label_text: String
var price: int
var upgrades: Array
var upgrade_count: int = 0
var maxed: bool = false

func check_price() -> void:
	if Values.currency < price or maxed:
		set_disabled(true)
	else:
		set_disabled(false)

func on_select() -> void:
	Values.currency -= price
	upgrades[upgrade_count]["effect"].call()
	upgrade_count += 1
	get_next_upgrade()

func set_properties() -> void:
	label_text = upgrades[upgrade_count]["label_text"]
	price = upgrades[upgrade_count]["price"]
	label.set_text(str(label_text))
	price_label.set_text(str(price))

func get_next_upgrade() -> void:
	if upgrades.size() > upgrade_count:
		set_properties()
	else:
		maxed = true
		label.set_text("Max upgrades")
		price_label.set_text("")

func init(_upgrades: Array) -> void:
	upgrades = _upgrades
	set_properties()
