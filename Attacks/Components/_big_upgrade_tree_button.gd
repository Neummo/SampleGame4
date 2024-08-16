extends TextureButton
class_name BigUpgradeTreeButton

@export var label: Label
@export var price_label: Label

var label_text: String
var price: int
var maxed: bool = false

func check_price() -> void:
	if Values.currency < price or maxed:
		set_disabled(true)
	else:
		set_disabled(false)

func on_select() -> void:
	Values.currency -= price
	lock("Max upgrades")

func lock(new_label_text: String) -> void:
	maxed = true
	label.set_text(new_label_text)
	price_label.set_text("")
	set_disabled(true)

func set_properties(_label_text: String, _price: int) -> void:
	label_text = _label_text
	price = _price
	label.set_text(str(label_text))
	price_label.set_text(str(price))
