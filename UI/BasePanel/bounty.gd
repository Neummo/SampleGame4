extends TextureButton

@onready var bountry_price_label: Label = $BountryPriceLabel
@onready var current_price: int = 1000
var bounty_active: bool = false
var bounty: CharacterBody2D
var spawner: Node2D
var stats: PlayerStats

func _ready() -> void:
	stats = get_tree().get_first_node_in_group("PlayerStats")
	spawner = get_tree().get_first_node_in_group("Spawner")
	bountry_price_label.set_text(str(current_price))
	if Values.currency < current_price or bounty_active or not Values.bounties_unlocked:
		set_disabled(true)
	set_process(false)

func check_price() -> void:
	if Values.currency < current_price or bounty_active or not Values.bounties_unlocked:
		set_disabled(true)
	else:
		set_disabled(false)

func _process(_delta: float) -> void:
	if is_instance_valid(bounty):
		stats.bounty.set_text("[" + str(snapped(bounty.global_position.x * 0.01, 1)) + ":" + str(snapped(bounty.global_position.y * 0.01 * -1, 1)) + "]")
	else:
		stats.bounty.set_text("")
		bountry_price_label.set_text(str(current_price))
		bounty_active = false
		check_price()
		set_process(false)

func _on_pressed() -> void:
	await spawner.spawn_bounty(int(floor(current_price / 1000)))
	Values.currency -= current_price
	bounty_active = true
	bountry_price_label.set_text("Bounty Active")
	set_disabled(true)
	bounty = get_tree().get_first_node_in_group("Bounty")
	bounty.health_component.value = 2000
	current_price = mini(current_price + 1000, 10000)
	set_process(true)
	
