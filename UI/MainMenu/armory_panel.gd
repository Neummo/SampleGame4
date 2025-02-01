extends TextureRect

@onready var weapon_unlock_button: TextureButton = $VBoxContainer/WeaponUnlockButton
@onready var weapon_unlock_button_2: TextureButton = $VBoxContainer/WeaponUnlockButton2
@onready var weapon_unlock_button_3: TextureButton = $VBoxContainer/WeaponUnlockButton3
@onready var weapon_unlock_button_4: TextureButton = $VBoxContainer/WeaponUnlockButton4
@onready var weapon_unlock_button_5: TextureButton = $VBoxContainer/WeaponUnlockButton5
@onready var currency: Label = $Currency

@onready var description: Label = $VBoxContainer/WeaponUnlockButton/Description
@onready var description2: Label = $VBoxContainer/WeaponUnlockButton2/Description
@onready var description3: Label = $VBoxContainer/WeaponUnlockButton3/Description
@onready var description4: Label = $VBoxContainer/WeaponUnlockButton4/Description
@onready var description5: Label = $VBoxContainer/WeaponUnlockButton5/Description

@onready var unlocks: Array = [
	{
		"button": weapon_unlock_button,
		"label": description,
		"value": null,
		"price": 0,
	},
	{
		"button": weapon_unlock_button_2,
		"label": description2,
		"value": null,
		"price": 1000,
	},
	{
		"button": weapon_unlock_button_3,
		"label": description3,
		"value": null,
		"price": 5000,
	},
	{
		"button": weapon_unlock_button_4,
		"label": description4,
		"value": null,
		"price": 10000,
	},
	{
		"button": weapon_unlock_button_5,
		"label": description5,
		"value": null,
		"price": 10000,
	},
]

func _ready() -> void:
	currency.set_text("Balance: " + str(Values.load_d1()))
	var unlock_values: Array = Values.get_weapon_unlocks()
	for index in unlocks.size():
		var value = unlocks[index]
		value["value"] = unlock_values[index]
		if value["value"]:
			value["button"].set_disabled(true)
			value["button"].set_texture_disabled(ResourceLoader.load("res://Assets/icons/selected/0" + str(index) + ".png"))
			value["label"].set_text("Acquired")
		if Values.saved_currency < value["price"]:
			value["button"].set_disabled(true)

func unlock(button: TextureButton, label: Label, price: int) -> void:
	Values.update_saved_currency(price * -1)
	button.set_disabled(true)
	label.set_text("Acquired")
	currency.set_text("Balance: " + str(Values.load_d1()))
	for unl in unlocks:
		if Values.saved_currency < price:
			unl["button"].set_disabled(true)

func _on_weapon_unlock_button_pressed() -> void:
	unlocks[0]["value"] = true
	Values.update_weapon_unlocks([
		unlocks[0]["value"],
		unlocks[1]["value"],
		unlocks[2]["value"],
		unlocks[3]["value"],
		unlocks[4]["value"],
	])
	weapon_unlock_button.set_texture_disabled(ResourceLoader.load("res://Assets/icons/selected/00.png"))
	unlock(weapon_unlock_button, description, unlocks[0]["price"])

func _on_weapon_unlock_button_2_pressed() -> void:
	unlocks[1]["value"] = true
	Values.update_weapon_unlocks([
		unlocks[0]["value"],
		unlocks[1]["value"],
		unlocks[2]["value"],
		unlocks[3]["value"],
		unlocks[4]["value"],
	])
	weapon_unlock_button_2.set_texture_disabled(ResourceLoader.load("res://Assets/icons/selected/01.png"))
	unlock(weapon_unlock_button_2, description2, unlocks[1]["price"])

func _on_weapon_unlock_button_3_pressed() -> void:
	unlocks[2]["value"] = true
	Values.update_weapon_unlocks([
		unlocks[0]["value"],
		unlocks[1]["value"],
		unlocks[2]["value"],
		unlocks[3]["value"],
		unlocks[4]["value"],
	])
	weapon_unlock_button_3.set_texture_disabled(ResourceLoader.load("res://Assets/icons/selected/02.png"))
	unlock(weapon_unlock_button_3, description3, unlocks[2]["price"])

func _on_weapon_unlock_button_4_pressed() -> void:
	unlocks[3]["value"] = true
	Values.update_weapon_unlocks([
		unlocks[0]["value"],
		unlocks[1]["value"],
		unlocks[2]["value"],
		unlocks[3]["value"],
		unlocks[4]["value"],
	])
	weapon_unlock_button_4.set_texture_disabled(ResourceLoader.load("res://Assets/icons/selected/03.png"))
	unlock(weapon_unlock_button_4, description4, unlocks[3]["price"])

func _on_weapon_unlock_button_5_pressed() -> void:
	unlocks[4]["value"] = true
	Values.update_weapon_unlocks([
		unlocks[0]["value"],
		unlocks[1]["value"],
		unlocks[2]["value"],
		unlocks[3]["value"],
		unlocks[4]["value"],
	])
	weapon_unlock_button_5.set_texture_disabled(ResourceLoader.load("res://Assets/icons/selected/04.png"))
	unlock(weapon_unlock_button_5, description5, unlocks[4]["price"])
