extends TextureButton

@onready var title: Label = $Title
@onready var description: Label = $Description
@onready var icon: TextureRect = $Icon

var id: int = 9999
var title_text: String
var description_text: String
var icon_path: String
var on_click
var card: Dictionary

func roll_card() -> void:
	card = get_card()
	id = card["id"]
	title_text = card["title"]
	description_text = card["description"]
	icon_path = card["icon"]
	on_click = card["effect"]
	
	title.text = title_text
	description.text = description_text
	icon.texture = ResourceLoader.load(icon_path)

func get_card() -> Dictionary:
	var rarity_data: Dictionary = ItemData.item_data[str(get_rarity())]["data"]
	var rand_index: int = randi_range(0, rarity_data.size() - 1)
	if rarity_data[str(rand_index)]["max"] == rarity_data[str(rand_index)]["hits"]:
		return get_card()
	rarity_data[str(str(rand_index))]["hits"] += 1
	return rarity_data[str(str(rand_index))]
	
func get_rarity() -> int:
	var roll: float = randf()
	if roll <= 0.05:
		return 2
	elif roll <= 0.2:
		return 1
	else:
		return 0

func _on_pressed() -> void:
	on_click.call()
