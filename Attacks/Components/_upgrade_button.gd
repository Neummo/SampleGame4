extends TextureButton
class_name UpgradeButton

@export var label: Label
@export var price_label: Label

var label_text: String
var price: int
var price_increase: int
var upgrades: int = 0
var max_upgrades
var maxed: bool = false

func set_properties(_label_text: String, _price: int, _price_increase: int, _max_upgrades) -> void:
	label_text = _label_text
	price = _price
	price_increase = _price_increase
	max_upgrades = _max_upgrades
	label.set_text(label_text)
	update_price_label()

func update_price_label() -> void:
	price_label.set_text(str(price))

func check_price() -> void:
	if Values.currency < price or maxed:
		set_disabled(true)
	else:
		set_disabled(false)

func on_select() -> void:
	if maxed:
		return
	Values.currency -= price
	Values.update_saved_currency(price)
	price += price_increase
	upgrades += 1
	update_price_label()
	if upgrades == max_upgrades:
		on_max_upgrades()
	
func on_max_upgrades() -> void:
	maxed = true
	label.set_text("Max upgrades reached")
	price_label.set_text("")
	set_disabled(true)
